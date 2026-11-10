-- The `--settings` every Claude Code session launched from Neovim carries. It registers the
-- UserPromptSubmit hook in `scripts/cc-session-title.sh`, which prefixes the session's title
-- with the project it was spawned in (`[nvim] - plan issue 10`).
--
-- Handing the hook over per launch, rather than registering it in ~/.claude/settings.json,
-- keeps it to sessions spawned from here -- `claude-work`'s separate config dir included --
-- and leaves sessions started from a shell alone.
--
-- Appended to claudecode.nvim's `terminal_cmd` (lua/plugins/init.lua) and to the
-- `<leader>cD` / `<leader>cW` spawns (lua/mappings.lua). Both hand the command line to a
-- shell, and Claude Code runs the hook's command through one too, hence the quoting.

local M = {}

local hook = vim.fn.stdpath "config" .. "/scripts/cc-session-title.sh"

---`--settings '<json>'`, quoted for the shell the `claude` command line runs in.
---@return string
function M.settings_arg()
  local settings = {
    hooks = {
      UserPromptSubmit = {
        { hooks = { { type = "command", command = vim.fn.shellescape(hook), timeout = 5 } } },
      },
    },
  }
  return "--settings " .. vim.fn.shellescape(vim.json.encode(settings))
end

return M
