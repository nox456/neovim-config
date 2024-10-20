return {
	  "nvim-tree/nvim-tree.lua",
	  version = "*",
	  cmd = "NvimTreeToggle",
	  dependencies = {
	    "nvim-tree/nvim-web-devicons",
	  },
	  opts = {
		sync_root_with_cwd = true,
		renderer = {
		    root_folder_label = false,
		    highlight_opened_files = "name"
		},
		filters = {
		    dotfiles = true
		},
		actions = {
			change_dir = {
				global = true
			},
			open_file = {
				quit_on_open = true
			}
		}
	  },
}
