vim.api.nvim_create_autocmd("BufDelete", {
	callback = function()
		local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(0))
		if bufname == "" then
			vim.o.showtabline = 0
			vim.cmd("Dashboard")
		end
	end,
})
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(0))
		local windows = #vim.api.nvim_list_wins()
		if not string.find(bufname, "NvimTree_1") and bufname ~= "" then
			if vim.o.showtabline == 0 then
				vim.o.showtabline = 2
			end
		elseif bufname == "" and windows == 1 then
			vim.o.showtabline = 0
		end
	end,
})
return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	dependencies = "nvim-tree/nvim-web-devicons",
	opts = {
		theme = "doom",
		shortcut_type = "number",
		disable_move = true,
		hide = {
			tabline = false,
		},
		config = {
			header = {
				"⠀⠀⠀⠀⠀⠀⠀⠀⢠⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀",
				"⠀⠀⠀⠀⠀⠀⠀⣠⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀",
				"⠀⠀⠀⠀⠀⠀⡰⠿⠿⠿⠿⢆⠀⠀⠀⠀⠀⠀⠀",
				"⠀⠀⠀⠀⠀⣴⣷⡀⠀⠀⢀⣼⣦⠀⠀⠀⠀⠀⠀",
				"⠀⠀⠀⠀⣼⣿⣿⣷⡀⢀⣾⣿⣿⣧⡀⠀⠀⠀⠀",
				"⠀⠀⠀⠈⠉⠉⠉⠉⠉⠈⠉⠉⠉⠉⠁⠀⠀⠀⠀",
				" _____    ___   ______  ______   _____   _____   _     ",
				"|  __ \\  / _ \\  | ___ \\ | ___ \\ |_   _| |  ___| | |    ",
				"| |  \\/ / /_\\ \\ | |_/ / | |_/ /   | |   | |__   | |    ",
				"| | __  |  _  | | ___ \\ |    /    | |   |  __|  | |    ",
				"| |_\\ \\ | | | | | |_/ / | |\\ \\   _| |_  | |___  | |____",
				" \\____/ \\_| |_/ \\____/  \\_| \\_|  \\___/  \\____/  \\_____/",
				"   _   _   _____   _____   _____  ______    ___        ",
				"  | | | | |_   _| |  ___| |_   _| | ___ \\  / _ \\       ",
				"  | | | |   | |   | |__     | |   | |_/ / / /_\\ \\      ",
				"  | | | |   | |   |  __|    | |   |    /  |  _  |      ",
				"  \\ \\_/ /  _| |_  | |___   _| |_  | |\\ \\  | | | |      ",
				"   \\___/   \\___/  \\____/   \\___/  \\_| \\_| \\_| |_/      ",
				"                                                       ",
			},
			center = {
				{
					icon = "  ",
					desc = "Projects",
					action = "Telescope project",
				},
				{
					icon = "  ",
					desc = "Tasks",
					action = "Tasks",
				},
				{
					icon = "  ",
					desc = "Plugin Manager",
					action = "Lazy",
				},
				{
					icon = "󰺾  ",
					desc = "Mason",
					action = "Mason",
				},
			},
			footer = function()
				local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
				return { "  If you can imagine it, you can program it ", "", "  " .. cwd }
			end,
            vertical_center = true
		},
	},
}
