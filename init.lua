-- [nfnl] Compiled from init.fnl by https://github.com/Olical/nfnl, do not edit.
unpack = (table.unpack or unpack)
table.unpack = (table.unpack or unpack)
local function nmap(key, action, description)
  return vim.keymap.set("n", key, action, {desc = description})
end
local function cmap(key, action, description)
  return vim.keymap.set("c", key, action, {desc = description})
end
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
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
vim.o.showtabline = 0
vim.o.laststatus = 0
vim.o.tags = "~/.vim/system.tags,tags"
require("gitsigns").setup()
nmap("<leader>gd", "<cmd>Gvdiffsplit<cr>", "[D]iff current file")
nmap("<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", "[G]it [S]tage hunk")
nmap("<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", "[G]it [S]tage hunk")
nmap("<leader>gr", "<cmd>Gitsigns preview_hunk<cr>", "[G]it [S]tage hunk")
nmap("<leader>gS", "<cmd>G stage %<cr>", "[G]it [S]tage current file")
nmap("<leader>gc", "<cmd>G commit<cr>", "[G]it [C]ommit")
nmap("]g", "<cmd>Gitsigns next_hunk<cr>")
nmap("[g", "<cmd>Gitsigns prev_hunk<cr>")
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
  nmap("-", open, "Open Oil")
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
nmap("[f", "<cmd>cprev<cr>", "Previous item in quickfix list")
nmap("]f", "<cmd>cnext<cr>", "Next item in quickfix list")
nmap("<C-c>", ":", "")
cmap("<C-c>", "<cr>", "")
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
  nmap("[d", d.goto_prev, "Go to previous diagnostic message")
  nmap("]d", d.goto_next, "Go to next diagnostic message")
  nmap("<leader>e", d.open_float, "Open floating diagnostic message")
  nmap("<leader>q", d.setloclist, "Open diagnostics list")
end
local function hide_diagnostics()
  return vim.diagnostic.config({signs = false, underline = false, virtual_text = false})
end
local function show_diagnostics()
  return vim.diagnostic.config({virtual_text = true, signs = true, underline = true})
end
nmap("<leader>dh", hide_diagnostics, "Hide Diagnostics")
nmap("<leader>ds", show_diagnostics, "Show Dianostics")
hide_diagnostics()
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
    _G.assert((nil ~= fun), "Missing argument fun on /home/falk/.config/nvim/init.fnl:167")
    return ((vim.o.ft ~= "fennel") and not fun.in_lisp())
  end
  au.setup({cr = {enable = true, autoclose = true, conf = {cond = _9_}}})
end
require("falkjet.snippets")
require("falkjet.autocomplete")
nmap("mr", "<Plug>Csurround", "Surround [R]eplace")
nmap("md", "<Plug>Dsurround", "Surround [D]elete")
vim.keymap.set("v", "ms", "<Plug>VSurround", {desc = "[S]urround"})
vim.keymap.set("i", "jj", "<Esc>")
do
  local _let_10_ = require("treesj")
  local setup = _let_10_["setup"]
  local _let_11_ = require("treesj.langs.utils")
  local helpers = _let_11_["helpers"]
  local is_2nd_child
  local function _12_(node)
    local parent = node:parent()
    return (parent:child(2) == node)
  end
  is_2nd_child = _12_
  setup({langs = {templ = {block = {}, argument_list = {both = {separator = ","}, split = {last_separator = true}}, parameter_list = {both = {separator = ","}, split = {last_separator = true}}, import_spec_list = {}, component_block = {}, script_block = {}, element = {}, tag_start = {both = {omit = {is_2nd_child}}}, function_declaration = {target_nodes = {"block"}}, func_literal = {target_nodes = {"block"}}}, zig = {initializer_list = {both = {separator = ","}, split = {last_separator = true}}, struct_initializer = {target_nodes = {"initializer_list"}}, anonymous_struct_initializer = {target_nodes = {"initializer_list"}}, call_expression = {both = {separator = ",", omit = {is_2nd_child}}}, block = {}, parameters = {both = {separator = ","}, split = {last_separator = true}}}, odin = {tuple_type = {both = {separator = ","}, split = {last_separator = true}}, parameters = {both = {separator = ","}, split = {last_separator = true}}, call_expression = {both = {separator = ","}, split = {last_separator = true}}}}})
end
local function _13_()
  vim.cmd.Abolish("stirng", "string")
  return vim.cmd.Abolish("skirve", "skrive")
end
vim.defer_fn(_13_, 0)
do
  local _let_14_ = require("Comment")
  local setup = _let_14_["setup"]
  local _let_15_ = require("Comment.ft")
  local set_ft = _let_15_["set"]
  setup()
  set_ft("fennel", ";; %s")
  set_ft("scheme", ";; %s")
  set_ft("nasm", ";; %s")
  set_ft("templ", "// %s")
end
vim.api.nvim_create_user_command("FixTrailingSpace", "%s/\\s\\+$//g", {})
vim.api.nvim_create_user_command("MakeExecutable", "w | !chmod +x %", {})
vim.filetype.add({extension = {cshtml = "razor", maude = "maude", templ = "templ", tmpl = "gohtmltmpl", bqn = "bqn"}})
vim.opt.sw = 4
vim.opt.ts = 4
vim.opt.et = true
require("falkjet.run")
require("falkjet.dap")
require("falkjet.lsp")
require("falkjet.treesitter")
local function _16_()
  vim.bo.lisp = true
  return nil
end
vim.api.nvim_create_autocmd("FileType", {callback = _16_, pattern = "fennel"})
vim.g["g:conjure#client#fennel#aniseed#aniseed_module_prefix"] = "aniseed"
vim.g["conjure#client#guile#socket#pipename"] = (vim.fn.getcwd() .. "/.guile-repl.socket")
local sexp = require("treesitter-sexp")
sexp.setup({enabled = true, set_cursor = false})
vim.keymap.set({"n", "i"}, "<M-S-l>", "<cmd>TSSexp slurp_right<cr>")
vim.keymap.set({"n", "i"}, "<M-S-h>", "<cmd>TSSexp slurp_left<cr>")
vim.keymap.set({"n", "i"}, "<M-S-j>", "<cmd>TSSexp barf_left<cr>")
vim.keymap.set({"n", "i"}, "<M-S-k>", "<cmd>TSSexp barf_right<cr>")
local function _17_()
  vim.bo.lisp = true
  return nil
end
vim.api.nvim_create_autocmd("FileType", {callback = _17_, pattern = "clojure"})
vim.g.vimtex_mappings_enabled = 0
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_quickfix_mode = 1
vim.g.vimtex_syntax_conceal = {accents = 1, cites = 1, fancy = 1, greek = 1, ligatures = 1, math_bounds = 0, delimiters = 1, math_fracs = 1, math_super_sub = 1, math_symbols = 1, sections = 0, spacing = 1, styles = 1}
vim.g.compiler_gcc_ignore_unmatched_lines = true
vim.g.c_syntax_for_h = true
vim.g.zig_fmt_autosave = 0
vim.filetype.add({extension = {c3 = "c3", c3i = "c3", c3t = "c3"}})
vim.g.go_doc_keywordprg_enabled = 0
vim.g.go_def_mapping_enabled = 0
vim.g.go_fmt_autosave = 0
do
  local obsidian = require("obsidian")
  obsidian.setup({workspaces = {{name = "Obsidian Vault", path = "~/Documents/Obsidian Vault"}}})
  nmap("<leader>oo", "<cmd>ObsidianOpen<cr>", "[O]pen [O]bsidian")
  nmap("<leader>os", "<cmd>ObsidianOpen<cr>", "[O]bsidian [S]earch")
  nmap("<leader>ol", "<cmd>ObsidianOpen<cr>", "[O]bsidian [L]inks")
end
require("falkjet.bqn")
require("falkjet.html-indent")
local function _18_()
  return vim.keymap.set("n", "q", "<cmd>q<cr>", {buffer = true})
end
vim.api.nvim_create_autocmd("FileType", {callback = _18_, pattern = "help"})
return vim.cmd("autocmd BufWritePost *.templ silent! !templ generate %")
