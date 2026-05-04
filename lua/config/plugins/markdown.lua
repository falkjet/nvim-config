-- [nfnl] fnl/config/plugins/markdown.fnl
local function _1_()
  vim.g.vimwiki_list = {{path = "~/Documents/Vim Wiki", syntax = "markdown", ext = "md"}}
  vim.g.vimwiki_key_mappings = {headers = 0}
  return nil
end
do local _ = {{"vimwiki/vimwiki", init = _1_}} end
return {}
