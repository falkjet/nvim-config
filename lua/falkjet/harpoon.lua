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


--- Run vim commands instead of terminal commands
function runcmd(n)
	return function() vim.cmd(harpoon.get_term_config().cmds[n]) end
end

vim.keymap.set({ 'n', 't', 'i', 'v' }, '<F9>', runcmd(1), { desc = 'Harpoon Coommand 1' })
vim.keymap.set({ 'n', 't', 'i', 'v' }, '<F10>', runcmd(2), { desc = 'Harpoon Coommand 2' })
vim.keymap.set({ 'n', 't', 'i', 'v' }, '<F11>', runcmd(3), { desc = 'Harpoon Coommand 3' })
vim.keymap.set({ 'n', 't', 'i', 'v' }, '<F12>', runcmd(4), { desc = 'Harpoon Coommand 4' })
