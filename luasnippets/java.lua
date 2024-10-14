local ls = require 'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require 'luasnip.extras.fmt'.fmt
local fmta = require 'luasnip.extras.fmt'.fmta
local rep = require 'luasnip.extras'.rep


local function classname()
	return sn(nil, { i(1, vim.fn.expand("%:t:r")) })
end

return {
	s({ trig = 'maincls' },
		fmta([[
    class <> {
        public static void main(String[] args) {
            <>
        }
    }
    ]], { d(1, classname), i(0) })),
	s({ trig = 'main' },
		fmta([[
    public static void main(String[] args) {
        <>
    }
    ]], { i(0) })),
	s({ trig = 'cls' },
		fmta([[
    class <> {
        <>
    }
    ]], { d(1, classname), i(0) })),
}
