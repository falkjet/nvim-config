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
	command = 'lldb-dap',
}

dap.configurations.rust = {
	{
		name = "Rust debug",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input('Path to executable: ',
				vim.fn.getcwd() .. '/target/debug/', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = false,
	}
}


dap.configurations.c = {
	{
		name = "C debug debug",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input('Path to executable: ',
				vim.fn.getcwd() .. '/', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = false,
	}
}

dap.configurations.cpp = {
	{
		name = "C++ debug debug",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input('Path to executable: ',
				vim.fn.getcwd() .. '/', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = false,
	}
}

vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })

vim.keymap.set('n', '<leader>du', function() dapui.toggle() end)
vim.keymap.set('n', '<leader>dn', '<cmd>DapStepOver<cr>')
vim.keymap.set('n', '<leader>di', '<cmd>DapStepInto<cr>')
vim.keymap.set('n', '<leader>do', '<cmd>DapStepOut<cr>')
vim.keymap.set('n', '<leader>dc', '<cmd>DapContinue<cr>')
vim.keymap.set('n', '<leader>db', '<cmd>DapToggleBreakpoint<cr>')
