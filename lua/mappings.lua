require "nvchad.mappings"
local Snacks = require "snacks"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

map("n", "<leader>b", ":NvimTreeToggle<CR>")

map("n", "<leader>s", ":w<CR>")

map("n", "<leader>q", ":q<CR>")

map("n", "<leader>w", ":Bdelete<CR>", { remap = true })

map("n", "<A-2>", "<cmd>bprev<CR>")

map("n", "<A-3>", "<cmd>bnext<CR>")

map("n", "<A-4>", "<cmd>tabprevious<CR>")

map("n", "<A-5>", "<cmd>tabnext<CR>")

map("n", "<leader>F", function()
  Snacks.picker.files { layout = "select" }
end)

map("n", "<leader>f", function()
  Snacks.picker.grep()
end)

map({ "n", "x" }, "<leader>i", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "general format file", remap = true })

map("n", "<leader>k", "gcc", { desc = "toggle comment", remap = true })

map("v", "<leader>k", "gc", { desc = "toggle comment", remap = true })

map("t", "<ESC><ESC>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

vim.keymap.del("n", "<leader>th")

map("n", "<leader>th", function()
  require("nvchad.term").new { pos = "bo sp" }
end, { desc = "terminal new horizontal term" })

map("n", "<leader>tv", function()
  require("nvchad.term").new { pos = "bo vsp" }
end, { desc = "terminal new vertical term" })

map("n", "<leader>tt", function()
  vim.cmd "tabnew"
  require("nvchad.term").new { pos = "bo vsp", size = 1 }
end, { desc = "terminal new vertical term" })

map("n", "<leader>tf", function()
  require("nvchad.term").new { pos = "float" }
end, { desc = "terminal new floating term" })

map("n", "<leader><", "zc", { desc = "Fold", remap = true })

map("n", "<leader>>", "za", { desc = "Unfold", remap = true })

map("n", "<leader>cc", function()
  require("nvchad.term").new { pos = "vsp", cmd = "claude && exit", size = 0.3 }
end, { desc = "terminal new horizontal term with claude code" })

map("n", "<leader>g", "<cmd>Neogit<CR>")

map("n", "<leader>ng", "<cmd>Gitsigns next_hunk<CR>")

map("n", "<leader>pg", "<cmd>Gitsigns prev_hunk<CR>")

map("n", "<leader>ghi", function ()
  Snacks.picker.gh_issue({ assignee = '@me' })
end)

map("n", "<leader>ghp", function ()
  Snacks.picker.gh_pr({ assignee = '@me' })
end)
