local onedark = require 'onedark'
local lualine = require 'lualine'
local catppuccin = require 'catppuccin'

onedark.setup {
  style = "deep",
  transparent = false,
}
onedark.load()

catppuccin.setup {
  falvour = 'auto',
  transparent_background = false,
}

lualine.setup {
  options = {
    icons_enabled = false,
    theme = 'catppuccin',
    component_separators = '|',
    section_separators = '',
  },
}

vim.cmd [[ colorscheme catppuccin ]]
