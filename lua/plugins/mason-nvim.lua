return {
	"williamboman/mason.nvim",
	lazy = false,
	dependencies = {
		"neovim/nvim-lspconfig",
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
		}
		for _, server in pairs(servers) do
			require("lspconfig")[server].setup({})
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
	end,
}
