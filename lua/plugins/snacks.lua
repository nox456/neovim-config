vim.api.nvim_create_autocmd("BufDelete", {
    callback = function()
        local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(0))
		local windows = #vim.api.nvim_tabpage_list_wins(0)
        if bufname == "" and windows == 1 then
            vim.o.showtabline = 0
            require("snacks").dashboard({ win = 0, buf = vim.api.nvim_win_get_buf(0) })
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
local function ip()
	local n = os.tmpname()

	os.execute("ip -o -4 addr list wlan0 | awk '{print $4}' | cut -d/ -f1 > " .. n)

	local ip
	for line in io.lines(n) do
		ip = line
	end
	os.remove(n)

	if ip == nil then
		ip = "localhost"
	end

	return ip
end
return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        dashboard = {
            enabled = true,
            pane_gap = 8,
            width = 100,
            preset = {
--                 header = [[
--  ________   ________   ________   ________   ___   _______    ___          
-- |\   ____\ |\   __  \ |\   __  \ |\   __  \ |\  \ |\  ___ \  |\  \         
-- \ \  \___| \ \  \|\  \\ \  \|\ /_\ \  \|\  \\ \  \\ \   __/| \ \  \        
--  \ \  \  ___\ \   __  \\ \   __  \\ \   _  _\\ \  \\ \  \_|/__\ \  \       
--   \ \  \|\  \\ \  \ \  \\ \  \|\  \\ \  \\  \|\ \  \\ \  \_|\ \\ \  \____  
--    \ \_______\\ \__\ \__\\ \_______\\ \__\\ _\ \ \__\\ \_______\\ \_______\
--     \|_______| \|__|\|__| \|_______| \|__|\|__| \|__| \|_______| \|_______|
--
-- ⠀⠀⠀⠀⠀⠀⠀⠀⢠⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⣠⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⡰⠿⠿⠿⠿⢆⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⣴⣷⡀⠀⠀⢀⣼⣦⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⣼⣿⣿⣷⡀⢀⣾⣿⣿⣧⡀⠀⠀⠀⠀
--
--          ___      ___  ___   _______    ___   ________   ________     
--         |\  \    /  /||\  \ |\  ___ \  |\  \ |\   __  \ |\   __  \    
--         \ \  \  /  / /\ \  \\ \   __/| \ \  \\ \  \|\  \\ \  \|\  \   
--          \ \  \/  / /  \ \  \\ \  \_|/__\ \  \\ \   _  _\\ \   __  \  
--           \ \    / /    \ \  \\ \  \_|\ \\ \  \\ \  \\  \|\ \  \ \  \ 
--            \ \__/ /      \ \__\\ \_______\\ \__\\ \__\\ _\ \ \__\ \__\
--             \|__|/        \|__| \|_______| \|__| \|__|\|__| \|__|\|__|
--             ]],
				header = [[
 _        _______  _______          _________ _______ 
( (    /|(  ____ \(  ___  )|\     /|\__   __/(       )
|  \  ( || (    \/| (   ) || )   ( |   ) (   | () () |
|   \ | || (__    | |   | || |   | |   | |   | || || |
| (\ \) ||  __)   | |   | |( (   ) )   | |   | |(_)| |
| | \   || (      | |   | | \ \_/ /    | |   | |   | |
| )  \  || (____/\| (___) |  \   /  ___) (___| )   ( |
|/    )_)(_______/(_______)   \_/   \_______/|/     \|
				]],
                keys = {
                    {
                        icon = "  ",
                        desc = "Projects",
                        action = ":Telescope project",
                    },
                    -- {
                    --     icon = "  ",
                    --     desc = "Tasks",
                    --     action = ":Tasks",
                    -- },
                    {
                        icon = "  ",
                        desc = "Plugin Manager",
                        action = ":Lazy",
                    },
					{
						icon = "  ",
						desc = "GitHub Dashboard",
						action = ":GHdash",
					}
                }
            },
            sections = {
				{section = "header"},
				{section = "terminal", cmd = 'cmatrix -u 8 -C blue -m -b -M "$(fortune programming)"',  height = 20, padding = 1, pane = 2, random = 20, enabled = function ()
					return not (require("snacks").git.get_root() ~= nil and vim.api.nvim_win_get_width(0) > 100)
				end},
				-- { section = "terminal", cmd = "chafa ~/Imágenes/Wallpapers/woods.jpg --format symbols --symbols vhalf --probe off --align center --stretch --size 100x18", ttl = 0, height = 20},
                { section = "keys", pane = 1, gap = 1, indent = 40 },
                { text = "\n  If you can imagine it, you can program it ", pane = 1, align = "center" },
				-- {
				-- 	section = "terminal",
				-- 	pane = 2,
				-- 	cmd = "fortune programming",
				-- 	height = 3,
				-- 	random = 20,
				--                 enabled = function()
				--                     return require("snacks").git.get_root() ~= nil and vim.api.nvim_win_get_width(0) > 100
				--                 end
				-- },
				-- {
				-- 	section = "terminal",
				-- 	pane = 2,
				-- 	title = "Current Branch\n",
				-- 	icon = "",
				-- 	height = 3,
				-- 	cmd = "git branch --show-current",
				--                 enabled = function()
				--                     return require("snacks").git.get_root() ~= nil and vim.api.nvim_win_get_width(0) > 100
				--                 end
				-- },
				            {
				                section = "terminal",
				                pane = 2,
				                title = "Recent Commits\n",
				                icon = "",
				                cmd = "git log --pretty=format:'%C(yellow)%h %C(green)(%an)%Creset %s' -n 5",
				                padding = 3,
				                height = 7,
				                enabled = function()
				                    return require("snacks").git.get_root() ~= nil and vim.api.nvim_win_get_width(0) > 100
				                end
				            },
                {
                    section = "terminal",
                    pane = 2,
                    icon = "",
                    title = "Open Issues",
                    cmd = "gh issue list --assignee '@me'",
                    height = 10,
                    enabled = function()
                        return (require("snacks").git.get_root() ~= nil and vim.api.nvim_win_get_width(0) > 100) and ip() ~= "localhost"
                    end
                },
                {
                    section = "terminal",
                    pane = 2,
                    icon = "",
                    title = "Open Pull Requests",
                    cmd = "gh pr list --author '@me'",
                    height = 10,
                    enabled = function()
                        return (require("snacks").git.get_root() ~= nil and vim.api.nvim_win_get_width(0) > 100) and ip() ~= "localhost"
                    end
                },
            }
        },
    },
}
