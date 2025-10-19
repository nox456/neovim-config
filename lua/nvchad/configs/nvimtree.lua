dofile(vim.g.base46_cache .. "nvimtree")

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
  on_attach = my_on_attach,
  filters = { dotfiles = true },
  disable_netrw = true,
  sync_root_with_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  view = {
    number = true,
    preserve_window_proportions = true,
  },
  actions = {
    open_file = {
      quit_on_open = true
    },
    change_dir = {
      global = true,
    },
  },
  renderer = {
    root_folder_label = false,
    highlight_git = true,
    highlight_diagnostics = "name",
    hidden_display = "all",
    full_name = true,
    indent_markers = { enable = true },
    icons = {
      glyphs = {
        default = "󰈚",
        folder = {
          default = "",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
        },
        git = { unmerged = "" },
      },
    },
  },
}
