return {
	"kevinhwang91/nvim-ufo",
	event = { "BufEnter *.*", "BufEnter */.git/*" },
	dependencies = { "kevinhwang91/promise-async" },
	opts = {
		provider_selector = function(bufnr, filetype, buftype)
			return { "treesitter", "indent" }
		end,
	},
}
