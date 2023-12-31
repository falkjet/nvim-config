local harpoon_ui = require 'harpoon.ui'
local harpoon = require 'harpoon'
local harpoon_mark = require 'harpoon.mark'
local harpoon_cmdui = require 'harpoon.cmd-ui'


vim.keymap.set('n', '<leader>hm', harpoon_mark.toggle_file, { desc = '(Un)[M]ark File' })
vim.keymap.set('n', '<leader>hh', harpoon_ui.toggle_quick_menu, { desc = 'File UI' })
vim.keymap.set('n', '<leader>hc', harpoon_cmdui.toggle_quick_menu, { desc = '[C]ommand UI' })

for i = 1, 10 do
  local k = '<a-' .. tostring(i % 10) .. '>'
  local desc = 'Harpoon goto file ' .. i
  local function action()
    harpoon_ui.nav_file(i)
  end
  vim.keymap.set({ 'n', 't', 'i', 'v' }, k, action, { desc = desc })
end
