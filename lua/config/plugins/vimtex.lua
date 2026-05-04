-- [nfnl] fnl/config/plugins/vimtex.fnl
local function _1_()
  vim.g.vimtex_mappings_enabled = 0
  vim.g.vimtex_view_method = "zathura"
  vim.g.vimtex_quickfix_mode = 1
  vim.g.vimtex_syntax_conceal = {accents = 1, cites = 1, fancy = 1, greek = 1, ligatures = 1, math_bounds = 0, delimiters = 1, math_fracs = 1, math_super_sub = 1, math_symbols = 1, sections = 0, spacing = 1, styles = 1}
  return nil
end
do local _ = {{"lervag/vimtex", ft = {"tex", "markdown"}, init = _1_}} end
return {}
