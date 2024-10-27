return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-project.nvim" },
	config = function()
		require("telescope").setup({
            defaults = {
                initial_mode = "normal"
            },
			extensions = {
				project = {
                    theme = "dropdown",
					on_project_selected = function(prompt_bufnr)
						require("telescope._extensions.project.actions").change_working_directory(prompt_bufnr)
					end,
				},
			},
		})
	end,
}
