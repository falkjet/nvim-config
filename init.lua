-- Compatibility fix
if table.unpack == nil then
  table.unpack = unpack
end


-- Setup lazy.nvim
--
-- https://github.com/folke/lazy.nvim#-installation
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone",
    "--filter=blob:none", "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.cmd [[ autocmd FileType help,qf noremap <buffer> q <cmd>q<cr> ]]
vim.cmd [[ autocmd FileType vim noremap <buffer> q <cmd>q<cr> ]]
vim.cmd [[ inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u ]]

require 'lazy'.setup(require 'falkjet.plugins')
require 'neoconf'.setup {}
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

vim.filetype.add { extension = { cshtml = 'razor' } }

vim.keymap.set('n', '<leader>gd', '<cmd>Gvdiffsplit<cr>', { desc = 'Diff current file' })
-- vim: ts=2 sts=2 sw=2 et
