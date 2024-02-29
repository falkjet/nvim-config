local dap = require 'dap'
local dapui = require 'dapui'

dapui.setup {}

dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    command = 'codelldb',
    args = { "--port", "${port}" },
  }
}

dap.adapters.lldb = {
  name = 'lldb',
  type = 'executable',
  command = 'lldb-vscode',
}

vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })

vim.keymap.set('n', '<leader>du', function() dapui.toggle() end)
vim.keymap.set('n', '<leader>dn', '<cmd>DapStepOver<cr>')
vim.keymap.set('n', '<leader>di', '<cmd>DapStepInto<cr>')
vim.keymap.set('n', '<leader>do', '<cmd>DapStepOut<cr>')
vim.keymap.set('n', '<leader>dc', '<cmd>DapContinue<cr>')
vim.keymap.set('n', '<leader>db', '<cmd>DapToggleBreakpoint<cr>')
