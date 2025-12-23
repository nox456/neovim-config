-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "tokyonight",

  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}

M.nvdash = {
  load_on_startup = false,
  header = {
    "                      ",
    "  ▄▄         ▄ ▄▄▄▄▄▄▄",
    "▄▀███▄     ▄██ █████▀ ",
    "██▄▀███▄   ███        ",
    "███  ▀███▄ ███        ",
    "███    ▀██ ███        ",
    "███      ▀ ███        ",
    "▀██ █████▄▀█▀▄██████▄ ",
    "  ▀ ▀▀▀▀▀▀▀ ▀▀▀▀▀▀▀▀▀▀",
    "                      ",
    "  Powered By  eovim ",
    "                      ",
  },
  buttons = {
    { txt = "  Projects", keys = "pp", cmd = "Telescope project" },
    { txt = " Github Issues", keys = "gi", cmd = ":lua require('snacks').picker.gh_issue({ assignee = '@me' })" },
    { txt = "󰓂 Github PRs", keys = "gp", cmd = ":lua require('snacks').picker.gh_pr({ assignee = '@me' })" },
    { txt = "󱥚  Themes", keys = "th", cmd = ":lua require('nvchad.themes').open()" },
    { txt = "  Mappings", keys = "ch", cmd = "NvCheatsheet" },
  },
}
M.ui = {
  statusline = {
    theme = "default",
    separator_style = "arrow",
    order = { "mode", "filepath", "git", "%=", "lsp_msg", "%=", "diagnostics", "cwd", "cursor" },
    modules = {
      filepath = function()
        local filepath = vim.fn.expand "%:p"
        local cwd = vim.fn.getcwd()
        if filepath:find(cwd, 1, true) == 1 then
          return "%#St_file# " .. filepath:sub(#cwd + 2, -(#vim.fn.expand "%:t") - 2) .. " "
        else
          return "%#St_relativepath# " .. vim.fn.expand "%:t" -- fallback to filename only
        end
      end,
    },
  },
}

return M
