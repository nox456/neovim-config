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

map({ "n", "t" }, "<leader>th", function()
  require("nvchad.term").new { pos = "bo sp" }
end, { desc = "terminal new horizontal term" })

map({ "n", "t" }, "<leader>tv", function()
  require("nvchad.term").new { pos = "bo vsp" }
end, { desc = "terminal new vertical term" })

map({ "n", "t" }, "<leader>tt", function()
  vim.cmd "tabnew"
  local empty_win = vim.api.nvim_get_current_win()
  require("nvchad.term").new { pos = "bo vsp", size = 1 }
  vim.api.nvim_win_close(empty_win, true)
end, { desc = "terminal new tab term" })

map({ "n", "t" }, "<leader>tf", function()
  require("nvchad.term").new { pos = "float" }
end, { desc = "terminal new floating term" })

map("n", "<leader><", "zc", { desc = "Fold", remap = true })

map("n", "<leader>>", "za", { desc = "Unfold", remap = true })

-- Claude Code
map("n", "<leader>cc", "<cmd>ClaudeCode<cr>", { desc = "Toggle Claude" })
map("n", "<leader>cf", "<cmd>ClaudeCodeFocus<cr>", { desc = "Focus Claude" })
map("n", "<leader>cr", "<cmd>ClaudeCode --resume<cr>", { desc = "Resume Claude" })
-- map("n", "<leader>cC", "<cmd>ClaudeCode --continue<cr>", { desc = "Continue Claude" })
map("n", "<leader>cm", "<cmd>ClaudeCodeSelectModel<cr>", { desc = "Select Claude model" })
map("n", "<leader>cb", "<cmd>ClaudeCodeAdd %<cr>", { desc = "Add current buffer" })
map("v", "<leader>cs", "<cmd>ClaudeCodeSend<cr>", { desc = "Send to Claude" })

-- Claude Code diff management
map("n", "<leader>ca", "<cmd>ClaudeCodeDiffAccept<cr>", { desc = "Accept diff" })
map("n", "<leader>cd", "<cmd>ClaudeCodeDiffDeny<cr>", { desc = "Deny diff" })

map("n", "<leader>g", "<cmd>Neogit<CR>")

map("n", "<leader>ng", "<cmd>Gitsigns next_hunk<CR>")

map("n", "<leader>pg", "<cmd>Gitsigns prev_hunk<CR>")

map("n", "<leader>ghi", function()
  Snacks.picker.gh_issue { assignee = "@me" }
end)

map("n", "<leader>ghp", function()
  Snacks.picker.gh_pr { assignee = "@me" }
end)

map("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>")
map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>")
map("n", "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>")

-- Yanky
map({"n","x"}, "p", "<Plug>(YankyPutAfter)")
map({"n","x"}, "P", "<Plug>(YankyPutBefore)")

map("n", "<c-p>", "<Plug>(YankyPreviousEntry)")
map("n", "<c-n>", "<Plug>(YankyNextEntry)")

map("n", "<leader>y", "<cmd>YankyRingHistory<CR>")
map("n", "<leader>yr", "<cmd>YankyClearHistory<CR>")
