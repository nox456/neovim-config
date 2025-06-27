return {
	"yetone/avante.nvim",
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	build = "make", -- ⚠️ must add this line! ! !
	event = "VeryLazy",
	version = false, -- Never set this value to "*"! Never!
	opts = {
		provider = "claude",
		providers = {
			claude = {
				endpoint = "https://api.anthropic.com",
				model = "claude-sonnet-4-20250514",
				timeout = 30000, -- Timeout in milliseconds
				extra_request_body = {
					temperature = 0.75,
					max_tokens = 20480,
				},
			},
		},
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
		-- "echasnovski/mini.pick",   -- for file_selector provider mini.pick
		-- "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
		-- "hrsh7th/nvim-cmp",        -- autocompletion for avante commands and mentions
		-- "ibhagwan/fzf-lua",        -- for file_selector provider fzf
		-- "stevearc/dressing.nvim",  -- for input provider dressing
		-- "folke/snacks.nvim",       -- for input provider snacks
		-- "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		-- "zbirenbaum/copilot.lua",  -- for providers='copilot'
	},
}
