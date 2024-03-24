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

local function in_mathzone()
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

return {
  s('lualatex', t('% !TeX program = lualatex')),
  s('root', t('% !TeX root = ')),
  s({ trig = '!' },
    fmta(
      [[
        \documentclass{article}

        \title{<>}
        \author{<>}

        \begin{document}
          \maketitle

          <>
        \end{document}
      ]],
      { i(1), i(2), i(0) }
    )),
  s({ trig = 'env' },
    fmta(
      [[
        \begin{<>}
          <>
        \end{<>}
      ]],
      { i(1), i(0), rep(1) }
    )
  ),
  s({ trig = "tii", snippetType = 'autosnippet' },
    fmta("\\textit{<>}", { d(1, get_visual) })),
  s({ trig = "tbb", snippetType = 'autosnippet' },
    fmta("\\textbf{<>}", { d(1, get_visual) })),
  s({ trig = '([^%a])ee', regTrig = true, wordTrig = false }, fmta("<>e^{<>}",
    { f(function(_, snip) return snip.captures[1] end), d(1, get_visual) })),
  s({ trig = "h1" }, fmta("\\section{<>}\n\n<>", { i(1), i(0) })),
  s({ trig = "h2" }, fmta("\\subsection{<>}\n\n<>", { i(1), i(0) })),
  s({ trig = "h3" }, fmta("\\subsubsection{<>}\n\n<>", { i(1), i(0) })),
  s({ trig = "ul" }, fmta([[
    \begin{itemize}
      \item <>
    \end{itemize}
  ]], { i(1) })),
  s({ trig = "ol" }, fmta([[
    \begin{enumerate}
      \item <>
    \end{enumerate}
  ]], { i(1) })),
  s({
    trig = "  li",
    condition = function()
      return tex_utils.in_env('itemize') or tex_utils.in_env('enumerate')
    end
  }, t '\\item '),
  s({ trig = '...', snippetType = 'autosnippet' }, t '\\ldots'),
  s({
      trig = 'mm',
      condition = function(line_to_cursor)
        return string.match(line_to_cursor, '^[^%a]*mm')
      end,
      snippetType = 'autosnippet'
    },
    fmta([[
      \begin{displaymath}
      <>
      \end{displaymath}
    ]], { i(0) })),
}
