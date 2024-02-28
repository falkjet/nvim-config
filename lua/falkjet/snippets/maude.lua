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

function pattern_condition(pattern)
  return function(line_to_cursor)
    return string.match(line_to_cursor, pattern)
  end
end

return {
  s({ trig = 'fmod' }, fmta([[
    fmod <> is
        <>
    endfm
  ]], { i(1), i(0) })),
  s({
    trig = 'var ',
    snippetType = 'autosnippet',
    condition = pattern_condition '^%s*var $',
  }, fmta('var <> .', { i(0) })),
  s({
    trig = 'vars ',
    snippetType = 'autosnippet',
    condition = pattern_condition '^%s*vars $',
  }, fmta('vars <> .', { i(0) })),
  s({
    trig = 'eq ',
    snippetType = 'autosnippet',
    condition = pattern_condition '^%s*eq $',
  }, fmta('eq <> .', { i(0) })),
  s({
    trig = 'op ',
    snippetType = 'autosnippet',
    condition = pattern_condition '^%s*op $',
  }, fmta('op <> .', { i(0) })),
}
