return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		disable_hint = true,
		disable_insert_on_commit = false,
        console_timeout = 8000,
		status = {
			HEAD_folded = true,
		},
		commit_editor = { show_staged_diff = false },
	},
}
