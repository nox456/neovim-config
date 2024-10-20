

return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline"
	},
	config = function()
		local cmp = require("cmp")

		cmp.setup({
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
