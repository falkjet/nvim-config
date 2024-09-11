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
  s('List', fmta([[
    sort <name>List .
    subsort <name_copy> <lt> <name_copy>List .
    op <id> : -<gt> <name_copy>List .
    op _<sep>_ : <name_copy>List <name_copy>List -<gt> <name_copy>List [ctor assoc id: <id_copy>] .
  ]], {
    name = i(1),
    name_copy = rep(1),
    id = i(2),
    id_copy = rep(2),
    lt = t '<',
    gt = t '>',
    sep = i(3),
  })),
  s('Set', fmta([[
    sort <name>Set .
    subsort <name_copy> <lt> <name_copy>Set .
    op <id> : -<gt> <name_copy>Set .
    op _<sep>_ : <name_copy>Set <name_copy>Set -<gt> <name_copy>Set [ctor assoc comm id: <id_copy>] .
  ]], {
    name = i(1),
    name_copy = rep(1),
    id = i(2),
    id_copy = rep(2),
    lt = t '<',
    gt = t '>',
    sep = i(3),
  })),
  s({ trig = 'oidset', snippetType = 'autosnippet' }, fmt([[
    omod OID-SET is
      sort OidSet .
      subsort Oid < OidSet .
      op none : -> OidSet [ctor] .
      op _;_ : OidSet OidSet -> OidSet [ctor assoc comm id: none] .
    endom
  ]], {})),
  s({ trig = 'multicast', snippetType = 'autosnippet' }, fmt([[
    omod MULTICAST is
      including OID-SET + MESSAGE-WRAPPER .

      op multicast_from_to_ : MsgContent Oid OidSet -> Msg [ctor] .

      var M : MsgContent .   vars SENDER ARECEIVER : Oid .
      var OTHER-RECEIVERS : OidSet .

      eq multicast M from SENDER to none = none .
      eq multicast M from SENDER to ARECEIVER ; OTHER-RECEIVERS =
            (msg M from SENDER to ARECEIVER)
            (multicast M from SENDER to OTHER-RECEIVERS) .
    endom
  ]], {})),
  s({ trig = 'messagewrapper', snippetType = 'autosnippet' }, fmt([[
    omod MESSAGE-WRAPPER is
      sort MsgContent .     --- message content, application-specific
      op msg_from_to_ : MsgContent Oid Oid -> Msg [ctor] .
    endom
  ]], {})),
}
