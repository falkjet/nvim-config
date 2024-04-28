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
local unicode = require 'falkjet.unicode'

local function pattern_condition(pattern)
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
  s({ trig = 'omod' }, fmta([[
    omod <> is
        <>
    endom
  ]], { i(1), i(0) })),
  s({ trig = 'mod' }, fmta([[
    mod <> is
        <>
    endm
  ]], { i(1), i(0) })),
  s({ trig = 'enum ', snippetType = 'autosnippet' }, fmt([[
    sort {} .
    ops {} : -> {} [ctor] .
  ]], { i(1), i(2), rep(1) })),
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
  s({
    trig = '([A-Z])(%d)',
    regTrig = true,
    snippetType = 'autosnippet'
  }, f(function(_, snip)
    local var = snip.captures[1]
    local n = snip.captures[2]
    return var .. unicode.subscript[n]
  end)),
}
