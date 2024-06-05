local obsidian = require 'obsidian'

obsidian.setup {
  workspaces = {
    {
      name = 'Obsidian Vault',
      path = '~/Documents/Obsidian Vault'
    },
  },
}

vim.keymap.set('n', '<leader>oo', '<cmd>ObsidianOpen<cr>', { desc = 'Open Obsidian' })
vim.keymap.set('n', '<leader>os', '<cmd>ObsidianSearch<cr>', { desc = 'Search' })
vim.keymap.set('n', '<leader>ol', '<cmd>ObsidianLinks<cr>', { desc = 'Links' })
