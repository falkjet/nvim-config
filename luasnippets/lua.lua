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

local function get_visual(_, parent)
  if #parent.snippet.env.LS_SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else
    return sn(nil, i(1))
  end
end

local function spaceif(args)
  return args[1][1] == '' and '' or ' '
end



return {
  s({ trig = "fun" }, fmta([[
    function<><>(<>)
      <>
    end
  ]], { f(spaceif, 1), i(1), i(2), i(0) })),
  s({ trig = "fnl" }, fmta([[
    local function <>(<>)
      <>
    end
  ]], { i(1), i(2), i(0) }))
}
