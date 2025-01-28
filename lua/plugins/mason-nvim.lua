return {
	"williamboman/mason.nvim",
	lazy = false,
	dependencies = {
		"neovim/nvim-lspconfig",
        {
            "folke/lazydev.nvim",
            ft = "lua",
            opts = {}
        }
	},
	config = function()
		require("mason").setup()
		local servers = {
			"pylsp",
			"html",
			"cssls",
			"emmet_language_server",
			"jsonls",
			"ts_ls",
			"lua_ls",
			"jdtls",
			"volar",
		}
		for _, server in pairs(servers) do
			require("lspconfig")[server].setup({
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			})
		end
		-- Exclude emmet in css files
		require("lspconfig").emmet_language_server.setup({
			init_options = {
				excludeLanguages = { "css" },
			},
		})
		-- Enable completion in css
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true
		require("lspconfig").cssls.setup({
			capabilities = capabilities,
		})
        -- Vue.js LSP configuration
		require("lspconfig").volar.setup({
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
			init_options = {
				vue = {
					hybridMode = false,
				},
				typescript = {
					tsdk = "/home/nox/.local/share/nvim/mason/packages/typescript-language-server/node_modules/typescript/lib",
				},
			},
		})
	end,
}
