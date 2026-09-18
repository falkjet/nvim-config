return {
	{
		"clojure-vim/vim-jack-in",
		dependencies = { "vim-dispatch" },
		cmd = { "Boot", "Clj", "Lein" },
	},
	{
		"Olical/conjure",
		dependencies = { "PaterJason/cmp-conjure" },
		ft = { "fennel", "clojure" },
		keys = {
			{ "<leader>er", "<cmd>ConjureEvalRootForm<cr>" },
			{ "<leader>eb", "<cmd>ConjureEvalFile" }
		},
		init = function()
			vim.g["conjure#filetypes"] = {"clojure", "fennel"}
			return nil
		end,
	}
}
