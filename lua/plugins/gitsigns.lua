return {
	"lewis6991/gitsigns.nvim",
	event = { "BufEnter *.*", "BufEnter */.git/*" },
	config = function()
		require("gitsigns").setup({
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "-" },
				topdelete = { text = "-" },
				changedelete = { text = "-" },
				untracked = { text = "┆" },
			},
			signs_staged = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "-" },
				topdelete = { text = "-" },
				changedelete = { text = "-" },
				untracked = { text = "┆" },
			},
		})
	end,
}
