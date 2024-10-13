local M = {}
local theme = require('themes.theme')

M.setup = function(theme_name)
	local palette = require('themes.'.. theme_name .. '.palette')
  vim.cmd('hi clear')

  vim.o.background = 'dark'
  if vim.fn.exists('syntax_on') then
    vim.cmd('syntax reset')
  end

  vim.o.termguicolors = true
  vim.g.colors_name = theme_name

  theme.set_highlights(palette)
end

return M
