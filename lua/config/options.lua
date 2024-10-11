local o = vim.opt

-- show line numbers
o.number = true
-- doesn't show the mode in statusline
o.showmode = false
-- highlight cursor line
o.cursorline = true
-- line numbers width
o.numberwidth = 2
-- doesn't show cursor position in statusline
o.ruler = false
-- disable neovim default intro
o.shortmess:append "sI"
-- disable case sensitive in search prompt ("/")
o.ignorecase = true
o.smartcase = true
-- disable mouse support
o.mouse = ""
-- always show signcolumn
o.signcolumn = "yes"
-- short timeout when pressing a mapped sequence
o.timeoutlen = 300
-- disabling netrw to use nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- enable 24-bit colour
o.termguicolors = true
