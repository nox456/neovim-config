return {
	"williamboman/mason.nvim",
	dependencies = {
    		"williamboman/mason-lspconfig.nvim",
    		"neovim/nvim-lspconfig",
	},
	lazy = false,
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = { "lua_ls",
				"cssls",
				"emmet_language_server",
				"ts_ls",
				"jsonls",
				"marksman",
				"jedi_language_server" 
			},
			automatic_installation = true
		})
	end
}
