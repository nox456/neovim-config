-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

local function stl_sep(direction, sep_hl, icon_hl, icon)
  local stl_utils = require "nvchad.stl.utils"
  local config = require("nvconfig").ui.statusline
  local sep_style = config.separator_style
  local seps = (type(sep_style) == "table" and sep_style) or stl_utils.separators[sep_style]

  local sep = "%#" .. sep_hl .. "#" .. seps[direction]
  local ic = "%#" .. icon_hl .. "#" .. icon

  if direction == "right" then
    return ic .. sep
  end
  return sep .. ic
end

M.base46 = {
  theme = "decay",

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
    { txt = "  Lazy", keys = "lz", cmd = "Lazy" },
  },
}
M.ui = {
  -- tabufline = {
  --   bufwidth = 40,
  -- },
  statusline = {
    theme = "default",
    separator_style = "arrow",
    order = { "mode", "filepath", "git", "%=", "lsp_msg", "%=", "diagnostics", "filename", "cwd", "file_position" },
    modules = {
      filename = function()
        local name = vim.fn.expand "%:t"
        if name == "" then
          return ""
        end
        return "%#St_gitIcons#" .. name .. " "
      end,
      filepath = function()
        local filepath = vim.fn.expand "%:p"
        local cwd = vim.fn.getcwd()
        if filepath:find(cwd, 1, true) == 1 then
          return "%#St_file# "
            .. "  "
            .. filepath:sub(#cwd + 2, -(#vim.fn.expand "%:t") - 2)
            .. " "
            .. stl_sep("right", "St_file_sep", "St_file", "")
        else
          return "%#St_relativepath# " .. vim.fn.expand "%:t" -- fallback to filename only
        end
      end,
      file_position = function()
        local current_line = vim.fn.line "."
        local total_lines = vim.fn.line "$"
        local percentage = math.floor((current_line / total_lines) * 100)

        return stl_sep("left", "St_pos_sep", "St_pos_icon", "󰦨 ") .. "%#St_pos_text# " .. percentage .. "%% "
      end,
    },
  },
}

return M
