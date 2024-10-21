return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"onsails/lspkind.nvim",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline"
	},
	config = function()
		local cmp = require("cmp")
		local lspkind = require("lspkind")

		cmp.setup({
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
				{ name = "buffer" },
				{ name = "path" },
				{ name = "cmdline" }
			},
			mapping = {
				['<Tab>'] = cmp.mapping.select_next_item(),
				['<S-Tab>'] = cmp.mapping.select_prev_item(),
				['<CR>'] = cmp.mapping.confirm({ select = true })
			},
			cmp.setup.cmdline(':', {
      				mapping = cmp.mapping.preset.cmdline()
			})
		})
	end,
}
