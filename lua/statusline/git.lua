-- Git state for the statusline's git sections (`git` and `worktree`), for any
-- buffer -- not only the file buffers gitsigns attaches to.
--
-- gitsigns stays the source whenever it has attached: it knows the buffer's own
-- repository and carries the diff counts. Everywhere else (the dashboard, a
-- terminal, nvim-tree, an empty buffer) the section falls back to the repository
-- of the window's cwd, minus the counts, which only exist per file.
--
-- That fallback is resolved once per cwd with an async `git rev-parse`, and the
-- branch is then read straight out of `<gitdir>/HEAD`, re-stat'ed at most once
-- per `poll_ms` -- so a checkout made from a terminal shows up without spawning
-- git on every redraw.

local M = {}

local config = {
  poll_ms = 1000,
}

-- cwd -> { root, gitdir, head, stamp, polled_at }, or false when the cwd is not
-- inside a work tree. Absent while the first lookup is still running.
local repos = {}
local pending = {}

local function redraw()
  vim.schedule(function()
    vim.cmd.redrawstatus()
  end)
end

-- `ref: refs/heads/<branch>` on a branch, a bare commit id when detached --
-- shortened the way gitsigns shortens it.
local function read_head(gitdir)
  local ok, lines = pcall(vim.fn.readfile, gitdir .. "/HEAD", "", 1)
  if not ok or not lines[1] then
    return nil
  end

  local ref = lines[1]:match "^ref: refs/heads/(.+)$" or lines[1]:match "^ref: (.+)$"
  return ref or lines[1]:sub(1, 7)
end

-- Keeps `head` in step with `<gitdir>/HEAD`. The stamp carries nanoseconds and
-- size: a checkout can rewrite HEAD twice within the same second.
local function update_head(repo)
  local now = vim.uv.now()
  if now - repo.polled_at < config.poll_ms then
    return
  end
  repo.polled_at = now

  local stat = vim.uv.fs_stat(repo.gitdir .. "/HEAD")
  local stamp = stat and string.format("%d.%d:%d", stat.mtime.sec, stat.mtime.nsec, stat.size) or nil
  if stamp ~= repo.stamp then
    repo.stamp = stamp
    repo.head = read_head(repo.gitdir)
  end
end

-- Spawned from a scheduled callback: this is reached while Neovim is drawing the
-- statusline, where starting a process is not allowed.
local function lookup(cwd)
  if pending[cwd] then
    return
  end
  pending[cwd] = true

  vim.schedule(function()
    local ok = pcall(
      vim.system,
      { "git", "rev-parse", "--absolute-git-dir", "--show-toplevel" },
      { cwd = cwd, text = true },
      function(result)
        local gitdir, root = (result.stdout or ""):match "^([^\n]+)\n([^\n]+)"
        repos[cwd] = result.code == 0 and gitdir and { root = root, gitdir = gitdir, polled_at = 0 } or false
        pending[cwd] = nil
        redraw()
      end
    )

    if not ok then
      repos[cwd] = false
      pending[cwd] = nil
    end
  end)
end

local function from_cwd()
  local cwd = vim.fn.getcwd(vim.g.statusline_winid or 0)
  local repo = repos[cwd]
  if repo == nil then
    lookup(cwd)
    return nil
  end
  if not repo then
    return nil
  end

  update_head(repo)
  if not repo.head then
    return nil
  end

  return { head = repo.head, root = repo.root, gitdir = repo.gitdir }
end

-- The git status of the buffer in the window being drawn: gitsigns' status dict
-- when gitsigns has attached, the cwd's repository otherwise, nil outside one.
function M.status()
  local b = vim.b[require("nvchad.stl.utils").stbufnr()]
  if b.gitsigns_head and b.gitsigns_head ~= "" and b.gitsigns_status_dict then
    return b.gitsigns_status_dict
  end
  return from_cwd()
end

-- A `git init` or `git worktree add` made under a running Neovim turns a cached
-- "not a repo" stale, so forget the cwd's entry whenever it is likely to change.
vim.api.nvim_create_autocmd({ "DirChanged", "FocusGained" }, {
  desc = "Re-resolve the cwd's git repository for the statusline",
  callback = function()
    repos[vim.fn.getcwd()] = nil
  end,
})

-- NvChad's own `git` module, but fed by `M.status` so it also renders on
-- buffers gitsigns never attaches to.
function M.module()
  local status = M.status()
  if not status or not status.head then
    return ""
  end

  local added = (status.added and status.added ~= 0) and ("  " .. status.added) or ""
  local changed = (status.changed and status.changed ~= 0) and ("  " .. status.changed) or ""
  local removed = (status.removed and status.removed ~= 0) and ("  " .. status.removed) or ""

  return "%#St_gitIcons#  " .. status.head .. added .. changed .. removed
end

return M
