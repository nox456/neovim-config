local function my_on_attach(bufnr)
	local api = require("nvim-tree.api")

	api.config.mappings.default_on_attach(bufnr)

	vim.keymap.set("n", "<C-CR>", api.tree.change_root_to_node, {
		desc = "CD",
		buffer = bufnr,
		noremap = true,
		silent = true,
		nowait = true,
	})
end

return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	cmd = "NvimTreeToggle",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		on_attach = my_on_attach,
		sync_root_with_cwd = true,
		renderer = {
			root_folder_label = false,
			highlight_diagnostics = "name",
			full_name = true,
			special_files = { "README.md", "readme.md", "package.json", "package-lock.json" },
			hidden_display = "all",
			indent_markers = {
				enable = true,
			}
		},
		filters = {
			dotfiles = true,
		},
		actions = {
			change_dir = {
				global = true,
			},
			open_file = {
				quit_on_open = true,
			},
		},
		diagnostics = {
			enable = true,
			show_on_dirs = true,
		},
		view = {
			preserve_window_proportions = true,
			number = true,
		}
	},
}
