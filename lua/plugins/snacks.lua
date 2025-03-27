vim.api.nvim_create_autocmd("BufDelete", {
    callback = function()
        local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(0))
        if bufname == "" then
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
                header = [[
 ________   ________   ________   ________   ___   _______    ___          
|\   ____\ |\   __  \ |\   __  \ |\   __  \ |\  \ |\  ___ \  |\  \         
\ \  \___| \ \  \|\  \\ \  \|\ /_\ \  \|\  \\ \  \\ \   __/| \ \  \        
 \ \  \  ___\ \   __  \\ \   __  \\ \   _  _\\ \  \\ \  \_|/__\ \  \       
  \ \  \|\  \\ \  \ \  \\ \  \|\  \\ \  \\  \|\ \  \\ \  \_|\ \\ \  \____  
   \ \_______\\ \__\ \__\\ \_______\\ \__\\ _\ \ \__\\ \_______\\ \_______\
    \|_______| \|__|\|__| \|_______| \|__|\|__| \|__| \|_______| \|_______|

⠀⠀⠀⠀⠀⠀⠀⠀⢠⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⣠⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⡰⠿⠿⠿⠿⢆⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⣴⣷⡀⠀⠀⢀⣼⣦⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⣼⣿⣿⣷⡀⢀⣾⣿⣿⣧⡀⠀⠀⠀⠀

         ___      ___  ___   _______    ___   ________   ________     
        |\  \    /  /||\  \ |\  ___ \  |\  \ |\   __  \ |\   __  \    
        \ \  \  /  / /\ \  \\ \   __/| \ \  \\ \  \|\  \\ \  \|\  \   
         \ \  \/  / /  \ \  \\ \  \_|/__\ \  \\ \   _  _\\ \   __  \  
          \ \    / /    \ \  \\ \  \_|\ \\ \  \\ \  \\  \|\ \  \ \  \ 
           \ \__/ /      \ \__\\ \_______\\ \__\\ \__\\ _\ \ \__\ \__\
            \|__|/        \|__| \|_______| \|__| \|__|\|__| \|__|\|__|
            ]],
                keys = {
                    {
                        icon = "  ",
                        desc = "Projects",
                        action = ":Telescope project",
                    },
                    {
                        icon = "  ",
                        desc = "Tasks",
                        action = ":Tasks",
                    },
                    {
                        icon = "  ",
                        desc = "Plugin Manager",
                        action = ":Lazy",
                    },
                }
            },
            sections = {
                { section = "header" },
                { section = "keys", pane = 1, gap = 1, indent = 40 },
                { text = "\n  If you can imagine it, you can program it ", pane = 1, align = "center" },
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
                        return require("snacks").git.get_root() ~= nil and vim.api.nvim_win_get_width(0) > 100
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
                        return require("snacks").git.get_root() ~= nil and vim.api.nvim_win_get_width(0) > 100
                    end
                },
            }
        },
    },
}
