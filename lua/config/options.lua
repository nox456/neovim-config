-- leader key
vim.g.mapleader = ","

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
-- 4 spaces indentation
o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.smartindent = true
o.softtabstop = 2
-- use system clipboard
o.clipboard = "unnamedplus"
-- Folds options
o.foldlevel = 99
o.foldlevelstart = 99
o.foldenable = true
-- Vertical splits
o.splitright = true
-- Disable invisible line at the end of the file
o.binary = true
o.endoffile = true

o.laststatus = 3
