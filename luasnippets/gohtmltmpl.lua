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



return {
	s({ trig = 'def' }, fmta([[
    {{ define "<>" }}
        <>
    {{ end }}
  ]], { i(1), i(0) })),
	s({ trig = 'tm' }, fmta([[
    {{ template "<>" <> }}
  ]], { i(1), i(2, '.') })),
}
