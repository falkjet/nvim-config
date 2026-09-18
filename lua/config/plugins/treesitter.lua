return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		main = "nvim-treesitter",
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "TSUpdate",
				callback = function()
					require("nvim-treesitter.parsers")["compila"] = {
						install_info = {
							url = "https://github.com/falkjet/tree-sitter-compila",
							queries = "queries",
						},
					}
					return nil
				end,
			})
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					pcall(vim.treesitter.start)
					if ("fennel" ~= vim.o.ft) then
						vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
						return nil
					else
						return nil
					end
				end,
			})
		end,
		opts = {
			indent = {
				enable = true,
			},
			highlight = {
				enable = true,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<M-o>",
					node_incremental = "<M-o>",
				},
			},
		},
		lazy = false,
	},
}
