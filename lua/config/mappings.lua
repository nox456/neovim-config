local map = vim.keymap.set

-- Window mappings
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Close window under the cursor" })
map("n", "<leader>q!", "<cmd>q!<CR>", { desc = "Close window (forced) under the cursor" })

-- Buffer mappings
map("n", "<leader>s", "<cmd>w<CR>", { desc = "Save buffer under the cursor" })
map("n", "<F2>", "<cmd>bprev<CR>", { desc = "Go to previous buffer" })
map("n", "<F3>", "<cmd>bnext<CR>", { desc = "Go to next buffer" })
map("n", "<leader>w", "<cmd>bdelete<CR>", { desc = "Close buffer under the cursor" })

-- Nvim-tree
map("n","<leader>b","<cmd>NvimTreeToggle<CR>", { desc = "Show file explorer" } )

-- Format Buffer
map("n", "<leader>i", function()
    require("conform").format({ async = true })
end, { desc = "Format the buffer under the cursos"})

-- Find Files
map("n", "<leader>f", "<cmd>Telescope live_grep<CR>", { desc = "Find words in workspace"})
