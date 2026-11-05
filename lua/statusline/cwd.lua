-- Directory section for the statusline: NvChad's `cwd` block, but named after
-- the git repository the cwd belongs to -- and in a linked worktree, after the
-- main repository, never the worktree. Naming the worktree is the `worktree`
-- section's job.
--
-- The repository comes from `statusline.git`'s lookup of the window's cwd. In
-- the main checkout the name is the toplevel's; in a linked worktree it is read
-- off the git dir all worktrees share (`--git-common-dir`): `proj/.git` and
-- `proj/.bare` both name `proj`, and so does a bare `proj.git`. Outside a
-- repository the section falls back to the cwd's own name, as NvChad's does.
--
-- Wired in from `lua/chadrc.lua` as the `cwd` module and drawn exactly like
-- NvChad's: an arrow-separated block on `lightbg`.

local stl = require "statusline.utils"

local M = {}

local config = {
  icon = "󰉋 ",
  -- Narrower than this, the block is dropped (NvChad's threshold).
  min_columns = 86,
}

-- cwd -> the name last drawn for it. `statusline.git` re-resolves the cwd on
-- every DirChanged/FocusGained; drawing the old name meanwhile keeps the block
-- from blinking out, or from falling back to the worktree's directory name.
local shown = {}

local function basename(path)
  local name = vim.fs.basename(path)
  return name ~= "" and name or path
end

local function repo_name(repo)
  if repo.commondir == repo.gitdir then
    return basename(repo.root)
  end

  -- `proj/.git`, `proj/.bare`: the repository is the directory holding it.
  local name = basename(repo.commondir)
  if name:sub(1, 1) == "." then
    return basename(vim.fs.dirname(repo.commondir))
  end
  return (name:gsub("%.git$", ""))
end

function M.module()
  if vim.o.columns < config.min_columns then
    return ""
  end

  local cwd = vim.fn.getcwd(vim.g.statusline_winid or 0)
  local repo = require("statusline.git").cwd_repo()
  if repo ~= nil then
    shown[cwd] = repo and repo_name(repo) or basename(cwd)
  end
  if not shown[cwd] then
    return ""
  end

  return stl.sep("left", "St_cwd_sep", "St_cwd_icon", config.icon) .. "%#St_cwd_text# " .. shown[cwd] .. " "
end

return M
