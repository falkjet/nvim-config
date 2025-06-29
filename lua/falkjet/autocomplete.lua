-- [nfnl] Compiled from fnl/falkjet/autocomplete.fnl by https://github.com/Olical/nfnl, do not edit.
local cmp = require("cmp")
local luasnip = require("luasnip")
local m = cmp.mapping
local function make_set(...)
  local args = {...}
  local tbl_16_auto = {}
  for _, val in ipairs(args) do
    local k_17_auto, v_18_auto = val, true
    if ((k_17_auto ~= nil) and (v_18_auto ~= nil)) then
      tbl_16_auto[k_17_auto] = v_18_auto
    else
    end
  end
  return tbl_16_auto
end
local emmet_filetypes = make_set("html", "eruby", "vue", "templ")
local function emmet_expandable_3f()
  return (emmet_filetypes[vim.o.ft] and (vim.fn["emmet#isExpandable"]() == 1))
end
local function emmet_expand()
  return vim.cmd("silent execute \"normal \\<Plug>(emmet-expand-abbr)\"")
end
local function on_tab(fallback)
  if luasnip.expand_or_locally_jumpable() then
    return luasnip.expand_or_jump()
  elseif emmet_expandable_3f() then
    return emmet_expand()
  else
    return fallback()
  end
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
return cmp.setup({snippet = {expand = _4_}, mapping = m.preset.insert({["<C-n>"] = m.select_next_item(), ["<C-p>"] = m.select_prev_item(), ["<C-d>"] = m.scroll_docs(-4), ["<C-f>"] = m.scroll_docs(4), ["<C-Space>"] = m.complete({}), ["<Tab>"] = m(on_tab, {"i", "s"}), ["<c-k>"] = m.confirm({select = true, behavior = cmp.ConfirmBehavior.Replace}), ["<S-Tab>"] = m(on_s_tab, {"i", "s"})}), sources = {{name = "conjure"}, {name = "buffer"}, {name = "nvim_lsp"}, {name = "tags"}}})
