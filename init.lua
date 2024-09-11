-- Compatibility fix
if table.unpack == nil then
  table.unpack = unpack
end



vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.cmd [[ autocmd FileType help,qf noremap <buffer> q <cmd>q<cr> ]]
vim.cmd [[ autocmd FileType vim noremap <buffer> q <cmd>q<cr> ]]
vim.cmd [[ inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u ]]
vim.cmd [[ autocmd BufWritePost *.templ silent! !templ generate % ]]

require 'neoconf'.setup {}
require 'neodev'.setup {}
require 'fidget'.setup {}
require 'gitsigns'.setup {}
require 'which-key'.setup {}
require 'treesj'.setup {}
require 'falkjet.theme'
require 'falkjet.options'
require 'falkjet.telescope'
require 'falkjet.diagnostics'
require 'falkjet.lsp'
require 'falkjet.snippets'
require 'falkjet.autocomplete'
require 'falkjet.run'
require 'falkjet.harpoon'
require 'falkjet.treesitter'
require 'falkjet.dap'
require 'falkjet.html-indent'
require 'falkjet.templ-indent'
require 'falkjet.folding'
require 'falkjet.dev'
require 'falkjet.termsplit'.setup {}
require 'falkjet.obsidian'
require 'falkjet.bqn'

vim.filetype.add {
  extension = {
    cshtml = 'razor',
    maude = 'maude',
    templ = 'templ',
    tmpl = 'gohtmltmpl',
    bqn = 'bqn',
  },
}

vim.keymap.set('n', 'mr', '<Plug>Csurround', { desc = 'Surround [R]eplace' })
vim.keymap.set('n', 'md', '<Plug>Dsurround', { desc = 'Surround [D]elete' })
vim.keymap.set('v', 'ms', '<Plug>VSurround', { desc = '[S]urround' })
vim.keymap.set('n', '<leader>gd', '<cmd>Gvdiffsplit<cr>', { desc = '[D]iff current file' })
vim.keymap.set('n', '<leader>gs', '<cmd>Gitsigns stage_hunk<cr>', { desc = '[G]it [S]tage hunk' })
vim.keymap.set('n', '<leader>gS', '<cmd>G stage %<cr>', { desc = '[G]it [S]tage current file' })
vim.keymap.set('n', '<leader>gc', '<cmd>G commit<cr>', { desc = '[G]it [C]ommit' })

vim.keymap.set({ 'n', 'i', 't' }, "<m-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = 'Left Pane' })
vim.keymap.set({ 'n', 'i', 't' }, "<m-j>", "<cmd>TmuxNavigateDown<cr>", { desc = 'Pane Below' })
vim.keymap.set({ 'n', 'i', 't' }, "<m-k>", "<cmd>TmuxNavigateUp<cr>", { desc = 'Pane Above' })
vim.keymap.set({ 'n', 'i', 't' }, "<m-l>", "<cmd>TmuxNavigateRight<cr>", { desc = 'Right Pane' })

vim.g.zig_fmt_autosave = 0

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


vim.g.sexp_mappings = {
  sexp_swap_list_backward    = '',
  sexp_swap_list_forward     = '',
  sexp_swap_element_backward = '',
  sexp_swap_element_forward  = '',
  sexp_capture_next_element  = '<M-S-l>',
  sexp_capture_prev_element  = '<M-S-h>',
  sexp_emit_head_element     = '<M-S-j>',
  sexp_emit_tail_element     = '<M-S-k>',
}

vim.g.sexp_filetypes = 'clojure,scheme,lisp,timl,racket'

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

vim.keymap.set('i', 'jj', '<esc>', {})
vim.keymap.set('i', '<esc>', '<nop>', {}) -- disable real esc key

-- vim: ts=2 sts=2 sw=2 et
