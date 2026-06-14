require "nvchad.autocmds"

vim.api.nvim_create_autocmd("BufDelete", {
  callback = function()
    local bufs = vim.t.bufs
    if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == "" then
      vim.cmd "Nvdash"
    end
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function ()
    local bufs = vim.t.bufs
    if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == "" then
      vim.cmd "Nvdash"
    end
  end
})

-- Make the snacks picker prefer the dashboard window when opening files.
-- The dashboard (nofile) and special windows like the Claude Code terminal
-- are both skipped by snacks' main-window finder, so it can otherwise fall
-- back to the terminal. Marking nvdash as the main window keeps files there.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "nvdash",
  callback = function(args)
    vim.b[args.buf].snacks_main = true
  end,
})
