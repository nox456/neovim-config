return {
	"williamboman/mason.nvim",
    lazy = false,
    dependencies = {
		"neovim/nvim-lspconfig",
    },
    config = function()
            require("mason").setup()
            local servers = {
                "pylsp",
                "html",
                "cssls",
                "emmet_language_server",
                "jsonls",
                "ts_ls",
                "lua_ls"
            }
            for _,server in pairs(servers) do
                require("lspconfig")[server].setup({})
            end
    end
}
