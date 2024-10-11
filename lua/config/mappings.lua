local map = vim.keymap.set

-- leader key
vim.g.mapleader = ","

-- Window mappings
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Close window under the cursor" })
map("n", "<leader>q!", "<cmd>q!<CR>", { desc = "Close window (forced) under the cursor" })

-- Buffer mappings
map("n", "<leader>s", "<cmd>w<CR>", { desc = "Save buffer under the cursor" })
map("n", "<F2>", "<cmd>bprev<CR>", { desc = "Go to previous buffer" })
map("n", "<F3>", "<cmd>bnext<CR>", { desc = "Go to next buffer" })

-- Theme picker
map("n", "<leader>th", "<cmd>Themery<CR>", { desc = "Show theme picker" })

-- Nvim-tree
map("n","<leader>b","<cmd>NvimTreeToggle<CR>", { desc = "Show file explorer" } )
