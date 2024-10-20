return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = {"BufEnter *.*", "BufEnter */.git/*"},
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
				"json",
				"jsdoc",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"sql"
			},
			sync_install = false,
			highlight = {
				enable = true
			}
		})
	end
}
