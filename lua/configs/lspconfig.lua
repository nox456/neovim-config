require("nvchad.configs.lspconfig").defaults()

local servers = { "ts_ls", "eslint", "cssls", "html", "hyprls", "jsonls", "biome", "prismals", "gh_actions_ls", "astro" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
