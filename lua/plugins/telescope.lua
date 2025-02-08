return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-project.nvim" },
	config = function()
		local project_actions = require("telescope._extensions.project.actions")
		require("telescope").setup({
			defaults = {
				initial_mode = "normal",
			},
			extensions = {
				project = {
					theme = "dropdown",
					on_project_selected = function(prompt_bufnr)
						require("telescope._extensions.project.actions").change_working_directory(prompt_bufnr)
                        vim.cmd("Bdelete")
                        vim.cmd("Dashboard")
					end,
					mappings = {
						n = {
							["d"] = project_actions.delete_project,
							["r"] = project_actions.rename_project,
							["c"] = project_actions.add_project_cwd,
							["C"] = project_actions.add_project_cwd,
							["f"] = project_actions.find_project_files,
							["b"] = project_actions.browse_project_files,
							["s"] = project_actions.search_in_project_files,
							["R"] = project_actions.recent_project_files,
							["w"] = project_actions.change_working_directory,
							["o"] = project_actions.next_cd_scope,
						},
						i = {
							["<c-d>"] = project_actions.delete_project,
							["<c-v>"] = project_actions.rename_project,
							["<c-a>"] = project_actions.add_project,
							["<c-A>"] = project_actions.add_project_cwd,
							["<c-f>"] = project_actions.find_project_files,
							["<c-b>"] = project_actions.browse_project_files,
							["<c-s>"] = project_actions.search_in_project_files,
							["<c-r>"] = project_actions.recent_project_files,
							["<c-l>"] = project_actions.change_working_directory,
							["<c-o>"] = project_actions.next_cd_scope,
							["<c-w>"] = project_actions.change_workspace,
						},
					},
				},
			},
		})
	end,
}
