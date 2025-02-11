-- [nfnl] Compiled from fnl/falkjet/autocomplete.fnl by https://github.com/Olical/nfnl, do not edit.
local cmp = require("cmp")
local luasnip = require("luasnip")
local m = cmp.mapping
local function on_tab(fallback)
  local _1_
  if luasnip.expand_or_locally_jumpable() then
    _1_ = luasnip.expand_or_jump
  else
    _1_ = fallback
  end
  return _1_()
end
local function on_s_tab(fallback)
  if luasnip.locally_jumpable(-1) then
    return luasnip.jump(-1)
  else
    return fallback()
  end
end
local function _4_(args)
  return luasnip.lsp_expand(args.body)
end
return cmp.setup({snippet = {expand = _4_}, mapping = m.preset.insert({["<C-n>"] = m.select_next_item(), ["<C-p>"] = m.select_prev_item(), ["<C-d>"] = m.scroll_docs(-4), ["<C-f>"] = m.scroll_docs(4), ["<C-Space>"] = m.complete({}), ["<Tab>"] = m(on_tab, {"i", "s"}), ["<c-k>"] = m.confirm({select = true, behavior = cmp.ConfirmBehavior.Replace}), ["<S-Tab>"] = m(on_s_tab, {"i", "s"})}), sources = {{name = "conjure"}}})
