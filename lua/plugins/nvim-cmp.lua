return {
	"hrsh7th/nvim-cmp",
	event = { "BufEnter *.*", "BufEnter */.git/*" },
	dependencies = {
		"onsails/lspkind.nvim",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp"
	},
	config = function()
		local cmp = require("cmp")
		local lspkind = require("lspkind")

		cmp.setup({
            completion = {
                completeopt = "menu,menuone"
            },
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol_text",
					maxwidth = 30
				})
			},
			window = {
				completion = cmp.config.window.bordered()
			},
			sources = {
                { name = "nvim_lsp" },
				{ name = "buffer" },
				{ name = "path" }
			},
			mapping = {
				['<Tab>'] = cmp.mapping.select_next_item(),
				['<S-Tab>'] = cmp.mapping.select_prev_item(),
				['<CR>'] = cmp.mapping.confirm({ select = true })
			}
		})
	end,
}
