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
local cond = require 'luasnip.extras.conditions'

local not_forward_jumpable = cond.make_condition(function()
	return not ls.locally_jumpable(1)
end)

local function filetype(ft)
	return cond.make_condition(function()
		return vim.o.filetype == ft
	end)
end

return {
	s({ trig = '\\alpha', wordTrig = false }, t 'α'),
	s({ trig = '\\beta', wordTrig = false }, t 'β'),
	s({ trig = '\\gamma', wordTrig = false }, t 'γ'),
	s({ trig = '\\Delta', wordTrig = false }, t '∆'),
	s({ trig = '\\delta', wordTrig = false }, t 'δ'),
	s({ trig = '\\epsilon', wordTrig = false }, t 'ϵ'),
	s({ trig = '\\zeta', wordTrig = false }, t 'ζ'),
	s({ trig = '\\eta', wordTrig = false }, t 'η'),
	s({ trig = '\\Theta', wordTrig = false }, t 'Θ'),
	s({ trig = '\\theta', wordTrig = false }, t 'θ'),
	s({ trig = '\\iota', wordTrig = false }, t 'ι'),
	s({ trig = '\\kappa', wordTrig = false }, t 'κ'),
	s({ trig = '\\Lambda', wordTrig = false }, t 'Λ'),
	s({ trig = '\\lambda', wordTrig = false }, t 'λ'),
	s({ trig = '\\mu', wordTrig = false }, t 'µ'),
	s({ trig = '\\nu', wordTrig = false }, t 'ν'),
	s({ trig = '\\Xi', wordTrig = false }, t 'Ξ'),
	s({ trig = '\\xi', wordTrig = false }, t 'ξ'),
	s({ trig = '\\Pi', wordTrig = false }, t 'Π'),
	s({ trig = '\\pi', wordTrig = false }, t 'π'),
	s({ trig = '\\varpi', wordTrig = false }, t 'ϖ'),
	s({ trig = '\\Sigma', wordTrig = false }, t 'Σ'),
	s({ trig = '\\sigma', wordTrig = false }, t 'σ'),
	s({ trig = '\\tau', wordTrig = false }, t 'τ'),
	s({ trig = '\\Phi', wordTrig = false }, t 'Φ'),
	s({ trig = '\\phi', wordTrig = false }, t 'ϕ'),
	s({ trig = '\\varphi', wordTrig = false }, t 'φ'),
	s({ trig = '\\chi', wordTrig = false }, t 'χ'),
	s({ trig = '\\Psi', wordTrig = false }, t 'Ψ'),
	s({ trig = '\\psi', wordTrig = false }, t 'ψ'),
	s({ trig = '\\Omega', wordTrig = false }, t 'Ω'),
	s({ trig = '\\omega', wordTrig = false }, t 'ω'),

	s({ trig = '\\clubsuit', wordTrig = false }, t '♣'),
	s({ trig = '\\heartsuit', wordTrig = false }, t '♡'),
	s({ trig = '\\spadesuit', wordTrig = false }, t '♠'),
	s({ trig = '\\diamondsuit', wordTrig = false }, t '♢'),
	s({ trig = '\\neg', wordTrig = false }, t '¬'),
	s({ trig = '\\emptyset', wordTrig = false }, t '∅'),
	s({ trig = '\\neq', wordTrig = false }, t '≠'),
	s({ trig = '\\nless', wordTrig = false }, t '≮'),
	s({ trig = '\\ngtr', wordTrig = false }, t '≯'),
	s({ trig = '\\ngeq', wordTrig = false }, t '≱'),
	s({ trig = '\\nleq', wordTrig = false }, t '≰'),
	s({ trig = '\\land', wordTrig = false }, t '∧'),
	s({ trig = '\\lor', wordTrig = false }, t '∨'),
	s({ trig = '\\cup', wordTrig = false }, t '∪'),
	s({ trig = '\\cap', wordTrig = false }, t '∩'),
	s({ trig = '\\equiv', wordTrig = false }, t '≡'),
	s({ trig = '\\le', wordTrig = false }, t '≤'),
	s({ trig = '\\ge', wordTrig = false }, t '≥'),
	s({ trig = '\\gtrless', wordTrig = false }, t '≷'),
	s({ trig = '\\subseteq', wordTrig = false }, t '⊆'),
	s({ trig = '\\subset', wordTrig = false }, t '⊂'),
	s({ trig = '\\prec', wordTrig = false }, t '≺'),
	s({ trig = '\\succ', wordTrig = false }, t '≻'),
	s({ trig = '\\rightarrow', wordTrig = false }, t '→'),
	s({ trig = '\\Rightarrow', wordTrig = false }, t '⇒'),
	s({ trig = '\\leftarrow', wordTrig = false }, t '←'),
	s({ trig = '\\rightsquigarrow', wordTrig = false }, t '⇝'),
	s({ trig = '\\leftsquigarrow', wordTrig = false }, t '⇝'),
	s({ trig = '\\leftrightsquigarrow', wordTrig = false }, t '↭'),
	s({ trig = '\\mapsto', wordTrig = false }, t '↦'),
	s({ trig = '\\vdash', wordTrig = false }, t '⊢'),
	s({ trig = '\\models', wordTrig = false }, t '⊧'),
	s({ trig = '\\top', wordTrig = false }, t '⊤'),
	s({ trig = '\\bot', wordTrig = false }, t '⊥'),
	s({ trig = '\\in', wordTrig = false }, t '∈'),
	s({ trig = '\\ni', wordTrig = false }, t '∋'),
	s({ trig = '\\notin', wordTrig = false }, t '∉'),
	s({ trig = '\\langle', wordTrig = false }, t '⟨'),
	s({ trig = '\\rangle', wordTrig = false }, t '⟩'),
	s({ trig = '\\cdot', wordTrig = false }, t '⋅'),
	s({ trig = '\\times', wordTrig = false }, t '×'),
	s({ trig = '\\circ', wordTrig = false }, t '∘'),
	s({ trig = '\\exists', wordTrig = false }, t '∃'),
	s({ trig = '\\forall', wordTrig = false }, t '∀'),
	s({ trig = '...', wordTrig = false }, t '…'),

	s('|-', t '⊢'),
	s('|=', t '⊧'),
	s('ø', t '∅'),
	s('>=', t '≥'),
	s('<=', t '≤'),
	s('!=', t '≠'),
	s('cc', t '⊂'),
	s('ce', t '⊆'),
	s('<~>', t '↭'),
	s('~>', t '⇝'),
	s('|->', t '↦'),
	s('<->', t '↔'),
	s('<-', t '←'),
	s('->', t '→'),
	s('<=>', t '⇔'),
	s('=>', t '⇒'),
	s('===', t '≡'),
	s('and', t '∧'),
	s('U', t '∪'),
	s('/\\', t '∧'),
	s('\\/', t '∨'),
	s('in', t '∈'),
	s('notin', t '∉'),
	s('and', t '∧'),
	s('or', t '∨'),
	s({ trig = '<', wordTrig = false }, t '⟨'),
	s({ trig = '>', wordTrig = false, condition = not_forward_jumpable * -filetype("html") }, t '⟩'),
	s('1/3', t '⅓'),
	s('2/3', t '⅔'),
	s('1/4', t '¼'),
	s('1/2', t '½'),
	s('3/4', t '¾'),
	s('1/5', t '⅕'),
	s('2/5', t '⅖'),
	s('3/5', t '⅗'),
	s('4/5', t '⅘'),
	s('1/6', t '⅙'),
	s('5/6', t '⅚'),
	s('1/8', t '⅛'),
	s('3/8', t '⅜'),
	s('5/8', t '⅝'),
	s('7/8', t '⅞'),
	s('0/3', t '↉'),

	s({ trig = '^n+1', wordTrig = false }, t 'ⁿ⁺¹'),
	s({ trig = '^n-1', wordTrig = false }, t 'ⁿ⁺¹'),
	s({ trig = '[\\^]([0-9+=n-])', regTrig = true, wordTrig = false, },
		f(function(_, snip) return unicode.superscript[snip.captures[1]] end)),
	s({ trig = '_([0-9+=-])', regTrig = true, wordTrig = false },
		f(function(_, snip) return unicode.subscript[snip.captures[1]] end)),

	s({ trig = 'tm', wordTrig = false }, t '™')
}
