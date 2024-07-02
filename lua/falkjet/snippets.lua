local luasnip = require 'luasnip'

-- require 'luasnip.loaders.from_vscode'.lazy_load()
require 'luasnip.loaders.from_lua'.lazy_load {}

luasnip.filetype_extend('markdown', { 'texmath' })
luasnip.filetype_extend('tex', { 'texmath' })
luasnip.filetype_extend('templ', { 'go' })

luasnip.config.setup {
  enable_autosnippets = true,
  store_selection_keys = "<Tab>",
  update_events = 'TextChanged,TextChangedI',
}
-- vim: ts=2 sts=2 sw=2 et
