return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		disable_hint = true,
		disable_insert_on_commit = false,
		console_timeout = 8000,
		auto_show_console = false,
		status = {
			HEAD_folded = true,
		},
		commit_editor = { spell_check = false, kind = "floating" },
		log_view = { kind = "floating" },
		graph_style = "unicode",
		integrations = {
			telescope = false,
		},
	}
}
