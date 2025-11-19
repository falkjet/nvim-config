-- [nfnl] fnl/config/plugins/autocomplete.fnl
local function cmp_opts()
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  local m = cmp.mapping
  local function make_set(...)
    local args = {...}
    local tbl_21_ = {}
    for _, val in ipairs(args) do
      local k_22_, v_23_ = val, true
      if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
        tbl_21_[k_22_] = v_23_
      else
      end
    end
    return tbl_21_
  end
  local emmet_filetypes = make_set("html", "eruby", "vue", "templ", "heex", "markdown")
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
  local mappings = {["<C-n>"] = m.select_next_item(), ["<C-p>"] = m.select_prev_item(), ["<C-d>"] = m.scroll_docs(-4), ["<C-f>"] = m.scroll_docs(4), ["<C-Space>"] = m.complete({}), ["<Tab>"] = m(on_tab, {"i", "s"}), ["<C-k>"] = m.confirm({select = true, behavior = cmp.ConfirmBehavior.Replace}), ["<S-Tab>"] = m(on_s_tab, {"i", "s"})}
  return {mapping = m.preset.insert(mappings), sources = {{name = "buffer"}, {name = "conjure"}, {name = "tags"}, {name = "luasnip"}}}
end
local function luasnip_config()
  local luasnip = require("luasnip")
  local from_lua = require("luasnip.loaders.from_lua")
  from_lua.lazy_load({})
  luasnip.filetype_extend("markdown", {"texmath"})
  luasnip.filetype_extend("tex", {"texmath"})
  luasnip.filetype_extend("templ", {"go"})
  return luasnip.config.setup({enable_autosnippets = true, store_selection_keys = "<Tab>", update_events = "TextChanged,TextChangedI"})
end
return {"hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp", "PaterJason/cmp-conjure", "quangnguyen30192/cmp-nvim-tags", "mattn/emmet-vim", "saadparwaiz1/cmp_luasnip", {"L3MON4D3/luasnip", config = luasnip_config}, {"hrsh7th/nvim-cmp", opts = cmp_opts}}
