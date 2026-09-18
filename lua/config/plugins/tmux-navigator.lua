return {
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft", "TmuxNavigateDown",
			"TmuxNavigateRight", "TmuxNavigateUp",
		},
		keys = {
			{
				"<m-h>",
				"<cmd>TmuxNavigateLeft<cr>",
				mode = { "n", "i", "t" },
				desc = "Left Pane",
			},
			{
				"<m-j>",
				"<cmd>TmuxNavigateDown<cr>",
				mode = { "n", "i", "t" },
				desc = "Below Pane",
			},
			{
				"<m-k>",
				"<cmd>TmuxNavigateUp<cr>",
				mode = { "n", "i", "t" },
				desc = "Above Pane",
			},
			{
				"<m-l>",
				"<cmd>TmuxNavigateRight<cr>",
				mode = { "n", "i", "t" },
				desc = "Right Pane",
			},
		},
		init = function()
			vim.g.tmux_navigator_no_mappings = 1
		end
	},
}
