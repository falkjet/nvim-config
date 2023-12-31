local luasnip = require 'luasnip'

-- require 'luasnip.loaders.from_vscode'.lazy_load()
require 'luasnip.loaders.from_lua'.lazy_load { paths = "~/.config/nvim/lua/falkjet/snippets/" }


luasnip.config.setup {
  enable_autosnippets = true,
  store_selection_keys = "<Tab>",
  update_events = 'TextChanged,TextChangedI',
}
-- vim: ts=2 sts=2 sw=2 et
