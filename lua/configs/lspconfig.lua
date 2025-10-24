require("nvchad.configs.lspconfig").defaults()

local servers = { "ts_ls", "eslint", "cssls", "html", "hyprls", "jsonls", "tailwindcss", "biome", "prismals" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
