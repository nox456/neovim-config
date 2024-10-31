local map = vim.keymap.set

-- Window mappings
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Close window under the cursor" })
map("n", "<leader>q!", "<cmd>q!<CR>", { desc = "Close window (forced) under the cursor" })

-- Buffer mappings
map("n", "<leader>s", "<cmd>w<CR>", { desc = "Save buffer under the cursor" })
map("n", "<F2>", "<cmd>bprev<CR>", { desc = "Go to previous buffer" })
map("n", "<F3>", "<cmd>bnext<CR>", { desc = "Go to next buffer" })
map("n", "<leader>w", "<cmd>Bdelete<CR>", { desc = "Close buffer under the cursor" })
map("n", "<leader>T", "<cmd>tabnew<CR>", { desc = "Create a new tab" } )
map("n", "<F5>", "<cmd>tabnext<CR>", { desc = "Got to next tab" })
map("n", "<F4>", "<cmd>tabprevious<CR>", { desc = "Go to previous tab" })
map("n", "<leader>Q", "<cmd>tabclose<CR>", { desc = "Close actual tab" })

-- Nvim-tree
map("n","<leader>b","<cmd>NvimTreeToggle<CR>", { desc = "Show file explorer" } )

-- Format Buffer
map("n", "<leader>i", function()
    require("conform").format({ async = true })
end, { desc = "Format the buffer under the cursor"})

-- Find Files
map("n", "<leader>f", "<cmd>Telescope live_grep<CR>", { desc = "Find words in workspace"})

-- Terminals
map("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal name=Terminal<CR>", { desc = "Open horizontal terminal"})
map("n", "<leader>tv", "<cmd>ToggleTerm size=40 direction=vertical name=Terminal<CR>", { desc = "Open vertical terminal"})
map("n", "<leader>tf", "<cmd>ToggleTerm direction=float name=Terminal<CR>", { desc = "Open floating terminal"})
map("t", "<leader>q", "<C-\\><C-N><C-W>q", { desc = "Terminal Escape terminal mode" })
map("t", "<C-W>", "<C-\\><C-N><C-W>", { desc = "Switch windows focus in terminal mode" })

-- Git
map("n", "<leader>g", "<cmd>LazyGit<CR>", { desc = "Open Git Manager" } )

-- Misc
map("n", "<Esc>", "<cmd>nohlsearch<CR>")
