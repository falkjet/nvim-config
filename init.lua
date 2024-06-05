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
require 'neodev'.setup {}
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
require 'falkjet.html-indent'
require 'falkjet.folding'
require 'falkjet.dev'
require 'falkjet.termsplit'.setup {}
require 'falkjet.obsidian'

vim.filetype.add {
  extension = {
    cshtml = 'razor',
    maude = 'maude',
    templ = 'templ',
    tmpl = 'gohtmltmpl',
  },
}

vim.keymap.set('n', 'mr', '<Plug>Csurround', { desc = 'Surround [R]eplace' })
vim.keymap.set('n', 'md', '<Plug>Dsurround', { desc = 'Surround [D]elete' })
vim.keymap.set('v', 'ms', '<Plug>VSurround', { desc = '[S]urround' })
vim.keymap.set('n', '<leader>gd', '<cmd>Gvdiffsplit<cr>', { desc = '[D]iff current file' })

vim.keymap.set({ 'n', 'i', 't' }, "<m-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = 'Left Pane' })
vim.keymap.set({ 'n', 'i', 't' }, "<m-j>", "<cmd>TmuxNavigateDown<cr>", { desc = 'Pane Below' })
vim.keymap.set({ 'n', 'i', 't' }, "<m-k>", "<cmd>TmuxNavigateUp<cr>", { desc = 'Pane Above' })
vim.keymap.set({ 'n', 'i', 't' }, "<m-l>", "<cmd>TmuxNavigateRight<cr>", { desc = 'Right Pane' })

vim.g.go_doc_keywordprg_enabled = 0
vim.g.go_def_mapping_enabled = 0

vim.g.vim_markdown_frontmatter = 1
vim.g.vim_markdown_toml_frontmatter = 1
vim.g.vim_markdown_math = 1

vim.g.vimtex_mappings_enabled = 0
vim.g.tex_flavor = 'latex'
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_quickfix_mode = 1
vim.o.conceallevel = 1
vim.g.tex_conceal = 'abmgs'
vim.g.vimtex_syntax_conceal = {
  accents = 1,
  cites = 1,
  fancy = 1,
  greek = 1,
  ligatures = 1,
  math_bounds = 0,
  delimiters = 1,
  math_fracs = 1,
  math_super_sub = 1,
  math_symbols = 1,
  sections = 0,
  spacing = 1,
  styles = 1,
}


local git_worktree = require 'git-worktree'
git_worktree.setup {
  autopush = false
}

require 'telescope'.load_extension('git_worktree')

vim.api.nvim_create_user_command("CreateWorktree", function()
  require('telescope').extensions.git_worktree.create_git_worktree()
end, {})

vim.api.nvim_create_user_command("Worktree", function()
  require('telescope').extensions.git_worktree.git_worktrees()
end, {})

require 'oil'.setup {
  win_options = {
    wrap = false,
  },
  skip_confirm_for_simple_edits = true,
}

vim.keymap.set('n', '-', '<cmd>Oil<cr>', { desc = "Open Oil" })

vim.api.nvim_create_autocmd("UIEnter", {
  pattern = "*",
  nested = true,
  callback = function()
    if #vim.fn.argv() == 0 then
      require 'oil'.open()
    end
  end
})

vim.cmd.vunmap('crr')

-- vim: ts=2 sts=2 sw=2 et
