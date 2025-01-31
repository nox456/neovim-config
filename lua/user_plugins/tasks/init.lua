local async = require("plenary.async")

local function create_floating_window()
	local buf = vim.api.nvim_create_buf(false, true)
	local width = math.floor(vim.o.columns * 0.6)
	local height = math.floor(vim.o.lines * 0.6)

	vim.api.nvim_open_win(buf, true, {
		style = "minimal",
		relative = "editor",
		col = math.floor((vim.o.columns - width) / 2),
		row = math.floor((vim.o.lines - height) / 2),
		width = width,
		height = height,
		border = "rounded",
	})
    vim.opt_local.guicursor = ""
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Loading..." })
	vim.opt_local.modifiable = false
end
local function update_floating_window(data)
	local buf = vim.api.nvim_win_get_buf(0)
	vim.opt_local.modifiable = true
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, data)
	vim.opt_local.modifiable = false
end

local function parse_lines(projects)
	local lines = {}
	for _, project in ipairs(projects) do
		table.insert(lines, "-- " .. project["title"] .. " --")
		table.insert(lines, "Tasks: ")
		for _, task in ipairs(project["tasks"]) do
			table.insert(lines, "* " .. task)
		end
	end
	return lines
end

vim.api.nvim_create_user_command("Tasks", function()
	async.run(create_floating_window, function()
		local path = vim.fn.stdpath("config")
		vim.fn.jobstart({ "node", path .. "/lua/user_plugins/tasks/api.mjs" }, {
			on_exit = function()
				local file = io.open(path .. "/lua/user_plugins/tasks/data.json", "r")
				local projects = vim.json.decode(file:read()).projects
				update_floating_window(parse_lines(projects))
			end,
		})
	end)
end, {})
