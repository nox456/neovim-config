return {
	{
		"navarasu/onedark.nvim",
		opts = { 
			style = "deep",
			transparent = true,
			ending_tildes = true,
			lualine = {
				transparent = true
			}
		}
	},
	{
 		"folke/tokyonight.nvim",
		opts = {
			style = "storm",
			transparent = true
		}
	},
	{
		"zaldih/themery.nvim",
		opts = {
			themes = { "onedark", "tokyonight" }
		}
	}
}
