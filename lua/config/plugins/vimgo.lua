-- [nfnl] fnl/config/plugins/vimgo.fnl
local function _1_()
  vim.g.go_doc_keywordprg_enabled = 0
  vim.g.go_def_mapping_enabled = 0
  vim.g.go_fmt_autosave = 0
  return nil
end
return {{"fatih/vim-go", ft = {"go"}, init = _1_}}
