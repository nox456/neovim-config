return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		disable_hint = true,
		disable_insert_on_commit = false,
		status = {
			HEAD_folded = true,
		},
		commit_editor = { show_staged_diff = false },
	},
}
