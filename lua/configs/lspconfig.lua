require("nvchad.configs.lspconfig").defaults()

local servers = { "ts_ls", "eslint" }
vim.lsp.enable(servers)

vim.lsp.config.eslint = {
  format = false,
  run = "onSave",
}

-- read :h vim.lsp.config for changing options of lsp servers
