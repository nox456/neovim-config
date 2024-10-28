return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {
        lualine_bold = true,
        on_highlights = function (highlights)
            highlights["DashboardFooter"] = { italic = true, bold = true }
        end
    },
}
