return {
    "stevearc/conform.nvim",
	event = { "BufEnter *.*", "BufEnter */.git/*" },
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            javascript = { "prettier" },
            html = { "prettier" },
            css = { "prettier" },
            json = { "prettier" },
            python = { "black" },
        },
        formatters = {
            prettier = {
                prepend_args = { "--tab-width", "4" },
            },
        },
    },
}
