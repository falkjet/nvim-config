-- Compatibility fix
if table.unpack == nil then
  table.unpack = unpack
end



vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.cmd [[ autocmd FileType help,qf noremap <buffer> q <cmd>q<cr> ]]
vim.cmd [[ autocmd FileType vim noremap <buffer> q <cmd>q<cr> ]]
vim.cmd [[ inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u ]]

require 'neoconf'.setup {}
require 'fidget'.setup {}
require 'gitsigns'.setup {}
require 'which-key'.setup {}
require 'falkjet.theme'
require 'falkjet.options'
require 'falkjet.telescope'
require 'falkjet.diagnostics'
require 'falkjet.lsp'
require 'falkjet.snippets'
require 'falkjet.autocomplete'
require 'falkjet.autopairs'
require 'falkjet.run'
require 'falkjet.harpoon'
require 'falkjet.treesitter'
require 'falkjet.dap'

vim.filetype.add { extension = { cshtml = 'razor', maude = 'maude' } }

vim.keymap.set('n', 'mr', '<Plug>Csurround', { desc = 'Surround [R]eplace' })
vim.keymap.set('n', 'md', '<Plug>Dsurround', { desc = 'Surround [D]elete' })
vim.keymap.set('v', 'ms', '<Plug>VSurround', { desc = '[S]urround' })
vim.keymap.set('n', '<leader>gd', '<cmd>Gvdiffsplit<cr>', { desc = '[D]iff current file' })

vim.keymap.set('', "<m-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = 'Left Pane' })
vim.keymap.set('', "<m-j>", "<cmd>TmuxNavigateDown<cr>", { desc = 'Pane Below' })
vim.keymap.set('', "<m-k>", "<cmd>TmuxNavigateUp<cr>", { desc = 'Pane Above' })
vim.keymap.set('', "<m-l>", "<cmd>TmuxNavigateRight<cr>", { desc = 'Right Pane' })



-- vim: ts=2 sts=2 sw=2 et
