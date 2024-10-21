return {
	"williamboman/mason.nvim",
	event = { "BufEnter *.*", "BufEnter */.git/*" },
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		{
			"stevearc/conform.nvim",
			opts = {
				formatters_by_ft = {
					lua = { "stylua" },
					javascript = { "prettier" },
					html = { "prettier" },
					css = { "prettier" },
					json = { "prettier" },
					python = { "black" },
				},
				formatters = {
					prettier = {
						prepend_args = { "--tab-width", "4" },
					},
				},
			},
		},
	},
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"cssls",
				"emmet_language_server",
				"ts_ls",
				"jsonls",
				"marksman",
				"jedi_language_server",
			},
			automatic_installation = true,
		})
	end,
}
