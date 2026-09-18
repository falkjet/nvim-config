return {
	{
		"stevearc/oil.nvim",
		opts = {
			win_options = { wrap = false },
			skip_confirm_for_simple_edits = true,
		},
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		keys = {
			{ "-", "<cmd>lua require 'oil'.open()<cr>" },
		},
		lazy = false,
	},
}
