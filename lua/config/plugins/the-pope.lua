return {
	{ "tpope/vim-abolish", },
	{ "tpope/vim-repeat", },
	{ "tpope/vim-rhubarb", },
	{ "tpope/vim-jdaddy", ft = { "json", "jsonc" } },
	{
		"tpope/vim-fugitive",
		cmd = {
			"Gedit", "Gsplit", "Gdiffsplit", "Gvdiffsplit",
			"Gread", "Gwrite", "Ggrep", "Glgrep",
			"GMove", "GRename", "GBrowse", "Git", "G",
		},
	},
	{
		"tpope/vim-sleuth",
		init = function()
			vim.g.sleuth_heuristics = 0
			vim.g.sleuth_python_heuristics = 1
			vim.g.sleuth_javascript_heuristics = 1
			return nil
		end,
	},
	{
		"tpope/vim-speeddating",
		keys = { "<c-a>", "<c-x>" },
	},
	{
		"tpope/vim-surround",
		keys = {
			{ "ms", "<Plug>VSurround", mode = "v" },
			{ "md", "<Plug>Dsurround" },
			{ "mr", "<Plug>Csurround" },
			{ "ms", "<Plug>Ysurround" },
		},
	},
	{
		"tpope/vim-tbone",
		cmd = { "Tmux", "Tyank", "Tput", "Twrite", "Tattach" },
	},
	{
		"tpope/vim-dispatch",
		cmd = { "Start", "Make", "Dispatch", "Focus" },
		keys = { { "<F5>", "<cmd>Dispatch<cr>" } },
		init = function()
			vim.g.dispatch_no_maps = 1
			return nil
		end,
	},
}
