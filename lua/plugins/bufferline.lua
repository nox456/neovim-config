return {
	'akinsho/bufferline.nvim',
	version = "*",
	dependencies = 'nvim-tree/nvim-web-devicons',
	opts = {
		options = {
			offsets = {
				{
				    filetype = "NvimTree",
				    text = "File Explorer",
				    text_align = "center",
				    highlight = "Directory",
				    separator = true
				}
			},
			show_buffers_close_icons = true,
			show_close_icon = true,
			buffer_close_icon = '󰅖',
			indicator = {
				style = 'underline'
			},
			separator_style = {'',''}
		}
	}
}
