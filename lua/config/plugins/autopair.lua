local function in_lisp()
	return (vim.o.lisp or ("fennel" == vim.o.ft) or ("clojure" == vim.o.ft))
end

return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		init = function()
			local autopairs = require "nvim-autopairs"
			autopairs.get_rules("'")[1]["not_filetypes"] = {"scheme", "lisp"}
			return nil
		end,
	}
}
