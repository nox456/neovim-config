-- Git worktree section for the statusline: names the linked worktree the
-- current buffer belongs to. Shows nothing in a repository's main checkout,
-- where the branch NvChad's `git` module already prints says it all.
--
-- The worktree's `root` and `gitdir` come from `statusline.git`, the same
-- source the `git` module renders from: gitsigns on file buffers, the cwd's
-- repository everywhere else. A linked worktree's gitdir
-- (`.git/worktrees/<name>`) holds a `commondir` file pointing back at the shared
-- repository; the main checkout's does not. That stat is cached per gitdir so it
-- is not paid on every render.
--
-- Wired into the statusline from `lua/chadrc.lua`, right after `git`, and drawn
-- in the same flat style -- `St_gitIcons` on the statusline background, no
-- separator -- so the two read as one group.

local M = {}

local config = {
  icon = "󰙅 ",
}

-- gitdir -> true when it belongs to a linked worktree. Worktrees are not added
-- or removed often enough under a running Neovim to justify re-checking.
local linked = {}

local function is_linked(gitdir)
  if linked[gitdir] == nil then
    linked[gitdir] = vim.uv.fs_stat(gitdir .. "/commondir") ~= nil
  end
  return linked[gitdir]
end

function M.module()
  local status = require("statusline.git").status()
  if not status or type(status.gitdir) ~= "string" or type(status.root) ~= "string" then
    return ""
  end
  if not is_linked(status.gitdir) then
    return ""
  end

  return "%#St_gitIcons#  " .. config.icon .. vim.fs.basename(status.root)
end

return M
