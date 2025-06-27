-- load options
require("config.options")

-- load lazy.nvim
require("config.lazy")

-- load mappings
require("config.mappings")

-- load user plugins
-- require("user_plugins.tasks")

-- load theme
vim.cmd("colorscheme tokyonight-storm")
