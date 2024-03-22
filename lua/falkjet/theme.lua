local onedark = require 'onedark'
local lualine = require 'lualine'

onedark.setup { style = "deep" }
onedark.load()

lualine.setup {
  options = {
    icons_enabled = false,
    theme = 'onedark',
    component_separators = '|',
    section_separators = '',
  },
}
