local onedark = require 'onedark'
local catppuccin = require 'catppuccin'

onedark.setup {
	style = "deep",
	transparent = false,
}
onedark.load()

catppuccin.setup {
	falvour = 'auto',
	transparent_background = true,
}



vim.cmd [[ colorscheme catppuccin ]]
