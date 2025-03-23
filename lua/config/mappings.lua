local map = vim.keymap.set

-- Window mappings
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Close window under the cursor" })
map("n", "<leader>q!", "<cmd>q!<CR>", { desc = "Close window (forced) under the cursor" })
map("n", "<C-W>=", "<cmd>horizontal resize +5<CR>", { desc = "Increase window height" })
map("n", "<C-W>-", "<cmd>horizontal resize -5<CR>", { desc = "Decrease window height", remap = true })
map("n", "<C-W>+", "<cmd>vertical resize +5<CR>", { desc = "Increase window width", remap = true })
map("n", "<C-W>_", "<cmd>vertical resize -5<CR>", { desc = "Decrease window width" })

-- Buffer mappings
map("n", "<leader>s", "<cmd>w<CR>", { desc = "Save buffer under the cursor" })
map("n", "<F2>", "<cmd>bprev<CR>", { desc = "Go to previous buffer" })
map("n", "<F3>", "<cmd>bnext<CR>", { desc = "Go to next buffer" })
map("n", "<leader>w", "<cmd>Bdelete<CR>", { desc = "Close buffer under the cursor" })
map("n", "<leader>T", "<cmd>tabnew<CR>", { desc = "Create a new tab" })
map("n", "<F5>", "<cmd>tabnext<CR>", { desc = "Got to next tab" })
map("n", "<F4>", "<cmd>tabprevious<CR>", { desc = "Go to previous tab" })
map("n", "<leader>Q", "<cmd>tabclose<CR>", { desc = "Close actual tab" })

-- Nvim-tree
map("n", "<leader>b", "<cmd>NvimTreeToggle<CR>", { desc = "Show file explorer" })

-- Format Buffer
map("n", "<leader>i", "<cmd>Format<CR>", { desc = "Format the buffer under the cursor" })

-- Telescope
map("n", "<leader>f", "<cmd>Telescope live_grep<CR>", { desc = "Find words in workspace " })
map("n", "<leader>P", "<cmd>Telescope project<CR>", { desc = "Open projects manager " })

-- Terminals
map("n", "<leader>th", ":ToggleTerm direction=horizontal<CR>", { desc = "Open horizontal terminal" })
map("n", "<leader>tv", ":ToggleTerm size=40 direction=vertical<CR>", { desc = "Open vertical terminal" })
map("n", "<leader>tf", "<cmd>ToggleTerm direction=float name=Terminal<CR>", { desc = "Open floating terminal" })
map("n", "<leader>tt", "<cmd>ToggleTerm direction=tab name=Terminal<CR>", { desc = "Open full terminal in tab " })
map("t", "<Esc><Esc>", "<C-\\><C-N>", { desc = "Espace from terminal mode" })

-- Git
map("n", "<leader>g", "<cmd>Neogit<CR>", { desc = "Open Git Manager" })

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
