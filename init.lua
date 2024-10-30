-- [nfnl] Compiled from init.fnl by https://github.com/Olical/nfnl, do not edit.
unpack = (table.unpack or unpack)
table.unpack = (table.unpack or unpack)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.hlsearch = false
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.mouse = "a"
vim.opt.showtabline = 2
vim.o.clipboard = "unnamedplus"
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.wo.signcolumn = "yes"
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.completeopt = "menuone,noselect"
vim.o.termguicolors = true
vim.opt.colorcolumn:append("80")
require("gitsigns").setup()
vim.keymap.set("n", "<leader>gd", "<cmd>Gvdiffsplit<cr>", {desc = "[D]iff current file"})
vim.keymap.set("n", "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", {desc = "[G]it [S]tage hunk"})
vim.keymap.set("n", "<leader>gS", "<cmd>G stage %<cr>", {desc = "[G]it [S]tage current file"})
vim.keymap.set("n", "<leader>gc", "<cmd>G commit<cr>", {desc = "[G]it [C]ommit"})
require("neoconf").setup()
require("neodev").setup()
require("which-key").setup()
vim.keymap.set({"n", "i", "t"}, "<m-h>", "<cmd>TmuxNavigateLeft<cr>", {desc = "Left Pane"})
vim.keymap.set({"n", "i", "t"}, "<m-j>", "<cmd>TmuxNavigateDown<cr>", {desc = "Below Pane"})
vim.keymap.set({"n", "i", "t"}, "<m-k>", "<cmd>TmuxNavigateUp<cr>", {desc = "Above Pane"})
vim.keymap.set({"n", "i", "t"}, "<m-l>", "<cmd>TmuxNavigateRight<cr>", {desc = "Right Pane"})
do
  local _let_1_ = require("oil")
  local setup = _let_1_["setup"]
  local open = _let_1_["open"]
  setup({win_options = {wrap = false}, skip_confirm_for_simple_edits = true})
  vim.keymap.set("n", "-", open, {desc = "Open Oil"})
  local function _2_()
    if (0 == #vim.fn.argv()) then
      return open()
    else
      return nil
    end
  end
  vim.api.nvim_create_autocmd("UIEnter", {pattern = "*", nested = true, callback = _2_})
end
require("falkjet.telescope")
require("falkjet.theme")
require("git-worktree").setup({autopush = false})
do
  local telescope = require("telescope")
  local git_worktree = require("git-worktree")
  local make_command = vim.api.nvim_create_user_command
  git_worktree.setup({autopush = false})
  telescope.load_extension("git_worktree")
  local function _4_()
    return telescope.extensions.git_worktree.create_git_worktree()
  end
  make_command("CreateWorktree", _4_, {})
  local function _5_()
    return telescope.extensions.git_worktree.git_worktrees()
  end
  make_command("Worktree", _5_, {})
end
vim.keymap.set("n", "[f", "<cmd>cprev<cr>", {desc = "Previous item in quickfix list"})
vim.keymap.set("n", "]f", "<cmd>cnext<cr>", {desc = "Next item in quickfix list"})
vim.o.conceallevel = 2
local function _6_()
  if (2 == vim.opt.conceallevel:get()) then
    vim.opt.conceallevel = 0
  else
    vim.opt.conceallevel = 2
  end
  return nil
end
vim.keymap.set("n", "<leader>tc", _6_)
do
  local d = vim.diagnostic
  local s = vim.keymap.set
  s("n", "[d", d.goto_prev, {desc = "Go to previous diagnostic message"})
  s("n", "]d", d.goto_next, {desc = "Go to next diagnostic message"})
  s("n", "<leader>e", d.open_float, {desc = "Open floating diagnostic message"})
  s("n", "<leader>q", d.setloclist, {desc = "Open diagnostics list"})
end
require("falkjet.harpoon")
do
  local _let_8_ = require("fidget")
  local setup = _let_8_["setup"]
  setup({})
end
require("falkjet.folding")
do
  local au = require("ultimate-autopair")
  local function _9_(fun)
    _G.assert((nil ~= fun), "Missing argument fun on /home/falk/.config/nvim/init.fnl:134")
    return ((vim.o.ft ~= "fennel") and not fun.in_lisp())
  end
  au.setup({cr = {enable = true, autoclose = true, conf = {cond = _9_}}})
end
require("falkjet.snippets")
require("falkjet.autocomplete")
vim.keymap.set("n", "mr", "<Plug>Csurround", {desc = "Surround [R]eplace"})
vim.keymap.set("n", "md", "<Plug>Dsurround", {desc = "Surround [D]elete"})
vim.keymap.set("v", "ms", "<Plug>VSurround", {desc = "[S]urround"})
vim.keymap.set("i", "jj", "<Esc>")
do
  local _let_10_ = require("treesj")
  local setup = _let_10_["setup"]
  setup()
end
vim.filetype.add({extension = {cshtml = "razor", maude = "maude", templ = "templ", tmpl = "gohtmltmpl", bqn = "bqn"}})
vim.opt.sw = 4
vim.opt.ts = 4
vim.opt.et = true
require("falkjet.run")
require("falkjet.dap")
require("falkjet.lsp")
require("falkjet.treesitter")
vim.g["g:conjure#client#fennel#aniseed#aniseed_module_prefix"] = "aniseed"
vim.g["conjure#filetype#scheme"] = "conjure.client.guile.socket"
vim.g["conjure#client#guile#socket#pipename"] = (vim.fn.getcwd() .. "/.guile-repl.socket")
local sexp = require("treesitter-sexp")
sexp.setup({enabled = true, set_cursor = false})
vim.keymap.set({"n", "i"}, "<M-S-l>", "<cmd>TSSexp slurp_right<cr>")
vim.keymap.set({"n", "i"}, "<M-S-h>", "<cmd>TSSexp slurp_left<cr>")
vim.keymap.set({"n", "i"}, "<M-S-j>", "<cmd>TSSexp barf_left<cr>")
vim.keymap.set({"n", "i"}, "<M-S-k>", "<cmd>TSSexp barf_right<cr>")
vim.g.vimtex_mappings_enabled = 0
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_quickfix_mode = 1
vim.g.vimtex_syntax_conceal = {accents = 1, cites = 1, fancy = 1, greek = 1, ligatures = 1, math_bounds = 0, delimiters = 1, math_fracs = 1, math_super_sub = 1, math_symbols = 1, sections = 0, spacing = 1, styles = 1}
vim.g.go_doc_keywordprg_enabled = 0
vim.g.go_def_mapping_enabled = 0
require("falkjet.obsidian")
require("falkjet.bqn")
require("falkjet.html-indent")
return require("falkjet.templ-indent")
