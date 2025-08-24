local map      = vim.keymap.set
local Snacks   = require("snacks")
local Terminal = require('toggleterm.terminal').Terminal

-- Window mappings
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Close window under the cursor" })
map("n", "<leader>q!", "<cmd>q!<CR>", { desc = "Close window (forced) under the cursor" })
map("n", "<C-W>=", "<cmd>horizontal resize +5<CR>", { desc = "Increase window height" })
map("n", "<C-W>-", "<cmd>horizontal resize -5<CR>", { desc = "Decrease window height", remap = true })
map("n", "<C-W>+", "<cmd>vertical resize +5<CR>", { desc = "Increase window width", remap = true })
map("n", "<C-W>_", "<cmd>vertical resize -5<CR>", { desc = "Decrease window width" })

-- Buffer mappings
map("n", "<leader>s", "<cmd>w<CR>", { desc = "Save buffer under the cursor" })
map("n", "<A-2>", "<cmd>bprev<CR>", { desc = "Go to previous buffer" })
map("n", "<A-3>", "<cmd>bnext<CR>", { desc = "Go to next buffer" })
map("n", "<leader>w", "<cmd>Bdelete<CR>", { desc = "Close buffer under the cursor" })
map("n", "<leader>T", "<cmd>tabnew<CR>", { desc = "Create a new tab" })
map("n", "<A-5>", "<cmd>tabnext<CR>", { desc = "Go to next tab" })
map("t", "<A-5>", "<C-\\><C-N><cmd>tabnext<CR>", { desc = "Go to next tab in terminal mode" })
map("n", "<A-4>", "<cmd>tabprevious<CR>", { desc = "Go to previous tab" })
map("t", "<A-4>", "<C-\\><C-N><cmd>tabprevious<CR>", { desc = "Go to previous tab in terminal mode" })
map("n", "<leader>Q", "<cmd>tabclose<CR>", { desc = "Close actual tab" })

-- Nvim-tree
map("n", "<leader>b", "<cmd>NvimTreeToggle<CR>", { desc = "Show file explorer" })

-- Format Buffer
map("n", "<leader>i", "<cmd>Format<CR>", { desc = "Format the buffer under the cursor" })

-- Snacks
map("n", "<leader>F", function()
	Snacks.picker.files({ layout = "select" })
end, { desc = "Find files in workspace" })
map("n", "<leader>f", function()
	Snacks.picker.grep()
end, { desc = "Find words in workspace" })

-- Claude
map("n", "<leader>cc", function ()
	vim.cmd("TermNew direction=vertical name=Claude size=80")
	vim.cmd('TermExec cmd="clear && claude && exit" go_back=0')
end, { desc = "Open Claude Code" })

-- Terminals
map("n", "<leader>th", "<cmd>TermNew direction=horizontal<CR>", { desc = "Open horizontal terminal" })
map("n", "<leader>tv", "<cmd>TermNew direction=vertical<CR>", { desc = "Open vertical terminal" })
map("n", "<leader>tf", "<cmd>TermNew direction=float name=Terminal<CR>", { desc = "Open floating terminal" })
map("n", "<leader>tt", "<cmd>TermNew direction=tab name=Terminal<CR>", { desc = "Open full terminal in tab" })
map("t", "<Esc><Esc>", "<C-\\><C-N>", { desc = "Escape from terminal mode" })
map("t", "<leader>th", "<C-\\><C-N><cmd>TermNew direction=horizontal<CR>", { desc = "Open horizontal terminal" })
map("t", "<leader>tv", "<C-\\><C-N><cmd>TermNew direction=vertical<CR>", { desc = "Open vertical terminal" })
map("t", "<leader>tf", "<C-\\><C-N><cmd>TermNew direction=float name=Terminal<CR>", { desc = "Open floating terminal" })
map("t", "<leader>tt", "<C-\\><C-N><cmd>TermNew direction=tab name=Terminal<CR>", { desc = "Open full terminal in tab" })
map("t", "<C-W>h", "<C-\\><C-N><cmd>wincmd h<CR>", { desc = "Go to left terminal" })
map("t", "<C-W>j", "<C-\\><C-N><cmd>wincmd j<CR>", { desc = "Go to bottom terminal" })
map("t", "<C-W>k", "<C-\\><C-N><cmd>wincmd k<CR>", { desc = "Go to top terminal" })
map("t", "<C-W>l", "<C-\\><C-N><cmd>wincmd l<CR>", { desc = "Go to right terminal" })

-- Git
map("n", "<leader>g", "<cmd>Neogit<CR>", { desc = "Open Git Manager" })
map("n", "<leader>ng", "<cmd>Gitsigns next_hunk<CR>", { desc = "Go to next git change in file" })
map("n", "<leader>pg", "<cmd>Gitsigns prev_hunk<CR>", { desc = "Go to previous git change in file" })

-- Misc
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- REST
map("n", "<leader>x", "<cmd>Rest run<CR>")

-- Folds
map("n", "<leader><", "zc", { desc = "Fold", remap = true })
map("n", "<leader>>", "za", { desc = "Unfold", remap = true })

-- Comment
map("n", "<leader>k", "gcc", { desc = "Comment", remap = true })
map("v", "<leader>k", "gc", { desc = "Comment", remap = true })
