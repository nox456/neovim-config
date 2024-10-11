return {
	  "nvim-tree/nvim-tree.lua",
	  version = "*",
	  lazy = false,
	  dependencies = {
	    "nvim-tree/nvim-web-devicons",
	  },
	  config = function()
		require("nvim-tree").setup {
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
		}
	  end,
}
