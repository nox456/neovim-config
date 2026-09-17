-- Claude Code section for the statusline: the account's organization, the
-- 5-hour session usage window, and how long is left before that window resets.
--
-- The organization is read straight out of the CLI's own `~/.claude.json`. The
-- usage window is not stored anywhere on disk, so `scripts/cc-usage.sh` fetches
-- it from the endpoint the CLI's `/usage` screen uses, with the OAuth token
-- Claude Code keeps refreshed, and caches the answer. This module spawns that
-- script -- never more often than `refresh_ms`, and only while the section is
-- actually on screen -- and reads nothing but its cache.
--
-- An earlier version got the same figures for free from Claude Code's
-- `statusLine` hook. That is the tidier source, but configuring the hook makes
-- Claude Code reserve a status-line row inside its own UI whether the hook
-- prints anything or not, which is not wanted here. Don't reintroduce it.
--
-- Wired into the statusline from `lua/chadrc.lua`, in the right-hand group,
-- next to `filename`. The bar has two tiers: `filename` and `diagnostics` are
-- flat text straight on the statusline background, while `cwd` and
-- `file_position` are arrow-separated blocks on `lightbg`. This section belongs
-- to the first tier, so it draws no separator and no block background -- only
-- its colours distinguish it, the way `diagnostics` does it.

local M = {}

local config = {
  -- Leads the section, and is the only thing separating it from `filename`
  -- in front of it -- this tier of the bar carries no separator glyphs.
  -- No leading space: `filename` already ends with one.
  icon = "  ",
  -- Writes the cache below; see the script for the request it makes.
  fetch_script = vim.fn.stdpath "config" .. "/scripts/cc-usage.sh",
  cache_file = (vim.env.XDG_CACHE_HOME or vim.env.HOME .. "/.cache") .. "/claude-code/usage.json",
  -- The CLI's own config, which is where the logged-in organization lives.
  account_file = vim.env.HOME .. "/.claude.json",
  -- Organization names get long ("<email>'s Organization" on personal plans);
  -- anything past this many characters is cut.
  org_max_width = 16,
  -- Display names for organizations whose own name says nothing useful. Keyed
  -- by the raw `organizationName` or by the shortened form of it, so either
  -- "nox030705@gmail.com's Organization" or "nox030705" matches the entry
  -- below. An alias is shown as written -- `org_max_width` does not apply.
  org_aliases = {
    ["nox030705"] = "Personal",
  },
  -- Usage percentages at which the figure turns yellow, then red.
  warn_at = 60,
  crit_at = 85,
  -- How often to hit the usage endpoint. It rate-limits, so keep this gentle.
  refresh_ms = 60000,
  -- How often to re-stat the cache file, and to redraw so the countdown ticks.
  poll_ms = 1000,
  redraw_ms = 30000,
}

local hl = {
  icon = "St_claude_icon",
  text = "St_claude_text",
  ok = "St_claude_ok",
  warn = "St_claude_warn",
  crit = "St_claude_crit",
}

-- Both inputs are files other processes rewrite underneath us, so each is
-- tracked rather than read once: `polled_at` throttles the stat, `stamp` is the
-- file identity the last parse belongs to.
local state = {
  usage = { polled_at = 0, stamp = nil, value = nil },
  account = { polled_at = 0, stamp = nil, value = nil },
  fetching = false,
  fetched_at = 0,
}

local function read_json(path)
  local ok, lines = pcall(vim.fn.readfile, path)
  if not ok or type(lines) ~= "table" or #lines == 0 then
    return nil
  end

  local decoded
  ok, decoded = pcall(vim.json.decode, table.concat(lines, "\n"))
  return ok and type(decoded) == "table" and decoded or nil
end

-- Re-reads a file, but only when it actually changed, and at most once per
-- `poll_ms`. The statusline is redrawn far too often to stat on every call, and
-- ~/.claude.json is 150KB, so neither the stat nor the parse can be per-render.
--
-- The stamp carries nanoseconds and size as well as seconds: `~/.claude.json` is
-- rewritten often enough that two writes can land in the same second.
local function tracked(entry, path)
  local now = vim.uv.now()
  if now - entry.polled_at < config.poll_ms then
    return entry.value
  end
  entry.polled_at = now

  local stat = vim.uv.fs_stat(path)
  if not stat then
    entry.stamp, entry.value = nil, nil
    return nil
  end

  local stamp = string.format("%d.%d:%d", stat.mtime.sec, stat.mtime.nsec, stat.size)
  if stamp ~= entry.stamp then
    entry.stamp = stamp
    entry.value = read_json(path)
  end

  return entry.value
end

local function usage()
  return tracked(state.usage, config.cache_file)
end

-- Throttled inline rather than inside the scheduled callback: this is reached
-- on every statusline redraw, and queueing a closure each time would be waste.
local function refresh()
  if state.fetching then
    return
  end

  local now = vim.uv.now()
  if state.fetched_at ~= 0 and now - state.fetched_at < config.refresh_ms then
    return
  end

  state.fetched_at = now
  state.fetching = true

  vim.schedule(function()
    local ok = pcall(vim.system, { config.fetch_script }, { text = true }, function()
      state.fetching = false
      vim.schedule(function()
        if M.is_active() then
          vim.cmd.redrawstatus()
        end
      end)
    end)

    if not ok then
      state.fetching = false
    end
  end)
end

local function truncate(text)
  if vim.fn.strchars(text) <= config.org_max_width then
    return text
  end
  return vim.fn.strcharpart(text, 0, config.org_max_width - 1) .. "…"
end

-- Personal plans name the organization after the account -- "<email>'s
-- Organization" -- which is all noise in a statusline. Keep the part that
-- actually identifies it.
local function shorten(name)
  if config.org_aliases[name] then
    return config.org_aliases[name]
  end

  local short = name:gsub("['\u{2019}]s [Oo]rganization%s*$", "")
  short = short:gsub("@.*$", "")
  short = vim.trim(short)
  if short == "" then
    return nil
  end

  return config.org_aliases[short] or truncate(short)
end

-- Read on every render rather than cached for the session: `/login` and an
-- organization switch both rewrite ~/.claude.json under a running Neovim, and a
-- statusline that keeps naming the organization you just left is worse than no
-- name at all. `tracked` keeps the actual cost to a stat.
local function organization()
  local account = tracked(state.account, config.account_file)
  local name = vim.tbl_get(account or {}, "oauthAccount", "organizationName")
  return type(name) == "string" and shorten(name) or nil
end

local function five_hour()
  local window = vim.tbl_get(usage() or {}, "five_hour")
  if type(window) ~= "table" or type(window.used_percentage) ~= "number" then
    return nil
  end

  -- Past its reset the cached percentage describes a window that no longer
  -- exists. Wait for the next fetch rather than show a figure that is wrong.
  if type(window.resets_at) == "number" and window.resets_at <= os.time() then
    return nil
  end

  return window
end

local function format_reset(resets_at)
  if type(resets_at) ~= "number" then
    return nil
  end

  local left = resets_at - os.time()
  if left <= 0 then
    return nil
  end

  local hours = math.floor(left / 3600)
  local minutes = math.floor(left % 3600 / 60)

  if hours > 0 then
    return string.format("%dh%02dm", hours, minutes)
  end
  return minutes > 0 and string.format("%dm", minutes) or "<1m"
end

local function usage_hl(used)
  if used >= config.crit_at then
    return hl.crit
  end
  return used >= config.warn_at and hl.warn or hl.ok
end

local function set_highlights()
  local ok, base46 = pcall(require, "base46")
  if not ok then
    return
  end

  local colors
  ok, colors = pcall(base46.get_theme_tb, "base_30")
  if not ok then
    return
  end

  -- Every group keeps the statusline background: this section is flat text, so
  -- only the foregrounds set it apart -- accent for the icon, plain white for
  -- the labels, severity colour for the figure that carries the news.
  vim.api.nvim_set_hl(0, hl.icon, { fg = colors.nord_blue, bg = colors.statusline_bg, bold = true })
  vim.api.nvim_set_hl(0, hl.text, { fg = colors.white, bg = colors.statusline_bg })
  vim.api.nvim_set_hl(0, hl.ok, { fg = colors.green, bg = colors.statusline_bg, bold = true })
  vim.api.nvim_set_hl(0, hl.warn, { fg = colors.yellow, bg = colors.statusline_bg, bold = true })
  vim.api.nvim_set_hl(0, hl.crit, { fg = colors.red, bg = colors.statusline_bg, bold = true })
end

-- Deferred out of the first render: `M.module` runs while Neovim is drawing the
-- statusline, where redrawing again is not allowed.
local initialised = false

local function init()
  if initialised then
    return
  end
  initialised = true

  vim.schedule(function()
    set_highlights()

    vim.api.nvim_create_autocmd("ColorScheme", {
      desc = "Re-derive the Claude Code statusline colors from the new theme",
      callback = set_highlights,
    })

    -- The reset countdown ticks on its own, so nudge the statusline even when
    -- nothing else in Neovim moves. Only while the section is on screen.
    local timer = vim.uv.new_timer()
    timer:start(
      config.redraw_ms,
      config.redraw_ms,
      vim.schedule_wrap(function()
        if M.is_active() then
          vim.cmd.redrawstatus()
        end
      end)
    )

    vim.cmd.redrawstatus()
  end)
end

local function terminal_bufnr()
  local ok, terminal = pcall(require, "claudecode.terminal")
  if not ok then
    return nil
  end

  local bufnr
  ok, bufnr = pcall(terminal.get_active_terminal_bufnr)
  if not ok or type(bufnr) ~= "number" or not vim.api.nvim_buf_is_valid(bufnr) then
    return nil
  end

  return bufnr
end

local function is_visible(bufnr)
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.api.nvim_win_get_buf(win) == bufnr then
      -- claudecode.nvim parks Snacks floats with `{ hide = true }` rather than
      -- closing them, and a parked window is not on screen.
      local ok, win_config = pcall(vim.api.nvim_win_get_config, win)
      if not ok or not win_config.hide then
        return true
      end
    end
  end
  return false
end

local function is_running(bufnr)
  local job = vim.b[bufnr].terminal_job_id
  return type(job) == "number" and vim.fn.jobwait({ job }, 0)[1] == -1
end

-- The section is shown while the Claude Code terminal is on screen in the
-- current tabpage and its session is still running -- not merely while the
-- buffer exists, and not only while it holds the cursor.
function M.is_active()
  local bufnr = terminal_bufnr()
  return bufnr ~= nil and is_visible(bufnr) and is_running(bufnr)
end

function M.module()
  init()

  if not M.is_active() then
    return ""
  end

  refresh()

  local parts = { "%#" .. hl.icon .. "#" .. config.icon }

  local org = organization()
  if org then
    parts[#parts + 1] = "%#" .. hl.text .. "#" .. org .. " "
  end

  local window = five_hour()
  if window then
    local used = math.floor(window.used_percentage + 0.5)
    parts[#parts + 1] = "%#" .. usage_hl(used) .. "#" .. used .. "%%"

    local reset = format_reset(window.resets_at)
    if reset then
      parts[#parts + 1] = "%#" .. hl.text .. "# 󰅐 " .. reset
    end
  else
    parts[#parts + 1] = "%#" .. hl.text .. "#—"
  end

  parts[#parts + 1] = "%#" .. hl.text .. "# "

  return table.concat(parts)
end

return M
