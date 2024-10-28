local function cwd()
	return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end

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
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = { "BufEnter *.*", "BufEnter */.git/*" },
		opts = {
			options = {
				section_separators = { left = "", right = "" },
				component_separators = { left = "|", right = "|" },
			},
			sections = {
				lualine_a = {
					{
						"mode",
						icon = "󰯙",
						separator = { left = "" },
					},
				},
				lualine_b = {
					"branch",
					{ "diff", symbols = { added = " ", modified = " ", removed = " " } },
					"diagnostics",
				},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {
					{ cwd, icon = " " },
					{ ip, icon = "󰍹 " },
					{ "progress", icon = "" },
				},
				lualine_z = {
					{
						"datetime",
						style = "%I:%M %p",
						icon = "",
						separator = { right = "" },
					},
				},
			},
			extensions = { "nvim-tree", "mason", "toggleterm" },
		},
	},
}
