local ls = require 'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require 'luasnip.extras.fmt'.fmt
local fmta = require 'luasnip.extras.fmt'.fmta
local rep = require 'luasnip.extras'.rep
local tex_utils = require 'falkjet.texutils'

local function get_visual(_, parent)
  if #parent.snippet.env.LS_SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else
    return sn(nil, i(1))
  end
end

return {
  s({
    trig = 'mm',
    condition = function(line_to_cursor)
      return string.match(line_to_cursor, '^[^%a]*mm')
    end,
    snippetType = 'autosnippet'
  }, fmta([[
    $$
    <>
    $$
  ]], { i(0) })),
  s({ trig = "tii" }, fmta("_<>_", { d(1, get_visual) })),
  s({ trig = "tbb" }, fmta("__<>__", { d(1, get_visual) })),
  s({ trig = "h1" }, fmta("<>\n<>\n\n<>", { i(1, 'Top Level Heading'), f(function(args)
    return string.rep('=', #args[1][1])
  end, 1), i(0) })),
  s({ trig = "h2" }, fmta("<>\n<>\n\n<>", { i(1, 'Sub Heading'), f(function(args)
    return string.rep('-', #args[1][1])
  end, 1), i(0) })),
  s({ trig = "h2" }, fmta("## <>\n\n<>", { i(1), i(0) })),
  s({ trig = "h3" }, fmta("### <>\n\n<>", { i(1), i(0) })),
  s({
    trig = "- ",
    condition = function(line_to_cursor) return string.match(line_to_cursor, '^%s*-%s*$') end,
  }, t '  - ')
}
