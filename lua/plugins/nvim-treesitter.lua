return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufEnter *.*", "BufEnter */.git/*" },
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = {
				"html",
				"css",
				"gitcommit",
				"gitignore",
				"http",
				"javascript",
				"typescript",
				"json",
				"jsdoc",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"sql",
                "glimmer"
			},
			sync_install = false,
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
			},
		})
	end,
}
