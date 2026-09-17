-- Shared helpers for the hand-written statusline modules wired up in `lua/chadrc.lua`.

local M = {}

-- Builds the arrow separator that closes a statusline block, in the same shape
-- NvChad's own modules use: the block's icon in `icon_hl`, then the separator
-- glyph for the configured `separator_style` in `sep_hl`.
M.sep = function(direction, sep_hl, icon_hl, icon)
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

return M
