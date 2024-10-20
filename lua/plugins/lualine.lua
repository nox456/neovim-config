local function time()
	return " " .. os.date("%I:%M %p")
end

local function cwd()
	return "  " .. vim.fn.fnamemodify(vim.fn.getcwd(),":t")
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

	return "󰍹  " ..  ip
end

return {
	{
    		'nvim-lualine/lualine.nvim',
    		dependencies = { 'nvim-tree/nvim-web-devicons' },
		event = "BufEnter *.*",
		opts = {
			sections = {
				lualine_a = {'mode'},
				lualine_b = {'branch','diff'},
				lualine_c = {'diagnostics'},
				lualine_x = { ip },
				lualine_y= { cwd },
				lualine_z= { time }
			},
			extensions = { 'nvim-tree' }
		}
	}
}
