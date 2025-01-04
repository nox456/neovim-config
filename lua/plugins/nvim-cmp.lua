return {
	"hrsh7th/nvim-cmp",
	event = { "BufEnter *.*", "BufEnter */.git/*" },
	dependencies = {
		"onsails/lspkind.nvim",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		local cmp = require("cmp")
		local lspkind = require("lspkind")
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

		cmp.setup({
			completion = {
				completeopt = "menu,menuone",
			},
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol_text",
					maxwidth = 30,
				}),
			},
			window = {
				completion = cmp.config.window.bordered(),
			},
			sources = {
				{ name = "nvim_lsp" },
				{ name = "buffer" },
				{ name = "path" },
			},
			mapping = {
				["<Tab>"] = cmp.mapping.select_next_item(),
				["<S-Tab>"] = cmp.mapping.select_prev_item(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			},
		})
	end,
}
