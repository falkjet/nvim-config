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

local function get_visual(_, parent)
  if #parent.snippet.env.LS_SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else
    return sn(nil, i(1))
  end
end

local function get_indented_visual(_, parent)
  local visual = parent.snippet.env.LS_SELECT_RAW
  if #visual > 0 then
    return sn(nil, i(1, visual))
  else
    return sn(nil, t '')
  end
end



return {
  s('main', fmta([[
    def main():
        <><>


    if __name__ == '__main__':
        main()
  ]], { isn(1, d(1, get_indented_visual), "$PARENT_INDENT    "), i(0) }))
}
