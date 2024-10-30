return {
    "lukas-reineke/indent-blankline.nvim",
	event = { "BufEnter *.*", "BufEnter */.git/*" },
    main = "ibl",
    opts = {
        exclude = {
            filetypes = {"dashboard"}
        }
    },
}
