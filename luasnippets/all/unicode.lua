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
local cond = require 'luasnip.extras.conditions'

local function jumpable(n)
	return cond.make_condition(function() ls.locally_jumpable(n or 1) end)
end

local not_forward_jumpable = -jumpable(1)

local function filetype(ft)
	return cond.make_condition(function()
		return vim.o.filetype == ft
	end)
end

local function texcmd(command, symbol)
	return s({ trig = command, wordTrig = false, hidden = true }, t(symbol))
end

local function texsym(trig, symbol)
	return s({ trig = trig, wordTrig = false, hidden = true }, t(symbol))
end

local function texsymw(trig, symbol)
	return s({ trig = trig, wordTrig = true, hidden = true }, t(symbol))
end

return {
	texcmd('\\alpha', 'α'),
	texcmd('\\beta', 'β'),
	texcmd('\\Gamma', 'Γ'),
	texcmd('\\gamma', 'γ'),
	texcmd('\\Delta', '∆'),
	texcmd('\\delta', 'δ'),
	texcmd('\\epsilon', 'ϵ'),
	texcmd('\\zeta', 'ζ'),
	texcmd('\\eta', 'η'),
	texcmd('\\Theta', 'Θ'),
	texcmd('\\theta', 'θ'),
	texcmd('\\iota', 'ι'),
	texcmd('\\kappa', 'κ'),
	texcmd('\\Lambda', 'Λ'),
	texcmd('\\lambda', 'λ'),
	texcmd('\\mu', 'µ'),
	texcmd('\\nu', 'ν'),
	texcmd('\\Xi', 'Ξ'),
	texcmd('\\xi', 'ξ'),
	texcmd('\\Pi', 'Π'),
	texcmd('\\pi', 'π'),
	texcmd('\\varpi', 'ϖ'),
	texcmd('\\Sigma', 'Σ'),
	texcmd('\\sigma', 'σ'),
	texcmd('\\tau', 'τ'),
	texcmd('\\Phi', 'Φ'),
	texcmd('\\phi', 'ϕ'),
	texcmd('\\varphi', 'φ'),
	texcmd('\\chi', 'χ'),
	texcmd('\\Psi', 'Ψ'),
	texcmd('\\psi', 'ψ'),
	texcmd('\\Omega', 'Ω'),
	texcmd('\\omega', 'ω'),

	texcmd('\\clubsuit', '♣'),
	texcmd('\\heartsuit', '♡'),
	texcmd('\\spadesuit', '♠'),
	texcmd('\\diamondsuit', '♢'),
	texcmd('\\neg', '¬'),
	texcmd('\\emptyset', '∅'),
	texcmd('\\neq', '≠'),
	texcmd('\\nless', '≮'),
	texcmd('\\ngtr', '≯'),
	texcmd('\\ngeq', '≱'),
	texcmd('\\nleq', '≰'),
	texcmd('\\land', '∧'),
	texcmd('\\lor', '∨'),
	texcmd('\\cup', '∪'),
	texcmd('\\cap', '∩'),
	texcmd('\\sqcup', '⊔'),
	texcmd('\\sqcap', '⊓'),
	texcmd('\\equiv', '≡'),
	texcmd('\\le', '≤'),
	texcmd('\\ge', '≥'),
	texcmd('\\gtrless', '≷'),
	texcmd('\\subseteq', '⊆'),
	texcmd('\\subset', '⊂'),
	texcmd('\\superset', '⊃'),
	texcmd('\\prec', '≺'),
	texcmd('\\succ', '≻'),
	texcmd('\\rightarrow', '→'),
	texcmd('\\Rightarrow', '⇒'),
	texcmd('\\leftarrow', '←'),
	texcmd('\\rightsquigarrow', '⇝'),
	texcmd('\\leftsquigarrow', '⇝'),
	texcmd('\\leftrightsquigarrow', '↭'),
	texcmd('\\mapsto', '↦'),
	texcmd('\\vdash', '⊢'),
	texcmd('\\models', '⊧'),
	texcmd('\\top', '⊤'),
	texcmd('\\bot', '⊥'),
	texcmd('\\in', '∈'),
	texcmd('\\ni', '∋'),
	texcmd('\\setminus', '∖'),
	texcmd('\\notin', '∉'),
	texcmd('\\langle', '⟨'),
	texcmd('\\rangle', '⟩'),
	texcmd('\\cdot', '⋅'),
	texcmd('\\times', '×'),
	texcmd('\\circ', '∘'),
	texcmd('\\exists', '∃'),
	texcmd('\\forall', '∀'),
	texcmd('\\hline', '────────────────────────────────────────────────────────────────────────────────'),

	texsym('...', '…'),
	texsym('[]', '□'),
	texsym('<>', '◇'),
	-- s({ trig = '--' }, t '—'),
	texsym('-|', '⊣'),
	texsym('|-', '⊢'),
	texsym('|=', '⊧'),
	texsym('ø', '∅'),
	texsym('>=', '≥'),
	texsym('<=', '≤'),
	texsym('!=', '≠'),
	texsym('cc', '⊂'),
	texsym('ce', '⊆'),
	texsym('<~>', '↭'),
	texsym('~>', '⇝'),
	texsym('|->', '↦'),
	texsym('<->', '↔'),
	texsym('<-', '←'),
	texsym('->', '→'),
	texsym('<=>', '⇔'),
	texsym('=>', '⇒'),
	texsym('===', '≡'),
	texsym('and', '∧'),
	texsym('U', '∪'),
	texsym('/\\', '∧'),
	texsym('\\/', '∨'),
	texsymw('in', '∈'),
	texsymw('notin', '∉'),
	texsymw('and', '∧'),
	texsymw('or', '∨'),
	s({ trig = '<', wordTrig = false, hidden = true }, t '⟨'),
	s({ trig = '>', wordTrig = false, hidden = true,
		condition = not_forward_jumpable * -filetype("html") }, t '⟩'),
	
	texsym('1/3', '⅓ '),
	texsym('2/3', '⅔ '),
	texsym('1/4', '¼'),
	texsym('1/2', '½'),
	texsym('3/4', '¾'),
	texsym('1/5', '⅕ '),
	texsym('2/5', '⅖ '),
	texsym('3/5', '⅗ '),
	texsym('4/5', '⅘ '),
	texsym('1/6', '⅙ '),
	texsym('5/6', '⅚ '),
	texsym('1/8', '⅛ '),
	texsym('3/8', '⅜ '),
	texsym('5/8', '⅝ '),
	texsym('7/8', '⅞ '),
	texsym('0/3', '↉ '),
	texsym('NN', 'ℕ'),

	s({ trig = '([-][-][-][-]*)', trigEngine = 'pattern', hidden = true },
		f(function(_, snip) return string.rep("─", snip.captures[1]:len()) end)),
	s({ trig = '^n+1', wordTrig = false }, t 'ⁿ⁺¹'),
	s({ trig = '^n-1', wordTrig = false }, t 'ⁿ⁻¹'),
	s({ trig = '^-1', wordTrig = false }, t '⁻¹'),

	s({ trig = '^0', wordTrig = false }, t'⁰'),
	s({ trig = '^1', wordTrig = false }, t'¹'),
	s({ trig = '^2', wordTrig = false }, t'²'),
	s({ trig = '^3', wordTrig = false }, t'³'),
	s({ trig = '^4', wordTrig = false }, t'⁴'),
	s({ trig = '^5', wordTrig = false }, t'⁵'),
	s({ trig = '^6', wordTrig = false }, t'⁶'),
	s({ trig = '^7', wordTrig = false }, t'⁷'),
	s({ trig = '^8', wordTrig = false }, t'⁸'),
	s({ trig = '^9', wordTrig = false }, t'⁹'),
	s({ trig = '^+', wordTrig = false }, t'⁺'),
	s({ trig = '^-', wordTrig = false }, t'⁻'),
	s({ trig = '^=', wordTrig = false }, t'⁼'),
	s({ trig = '^(', wordTrig = false }, t'⁽'),
	s({ trig = '^)', wordTrig = false }, t'⁾'),

	s({ trig = '_0', wordTrig = false }, t'₀'),
	s({ trig = '_1', wordTrig = false }, t'₁'),
	s({ trig = '_2', wordTrig = false }, t'₂'),
	s({ trig = '_3', wordTrig = false }, t'₃'),
	s({ trig = '_4', wordTrig = false }, t'₄'),
	s({ trig = '_5', wordTrig = false }, t'₅'),
	s({ trig = '_6', wordTrig = false }, t'₆'),
	s({ trig = '_7', wordTrig = false }, t'₇'),
	s({ trig = '_8', wordTrig = false }, t'₈'),
	s({ trig = '_9', wordTrig = false }, t'₉'),
	s({ trig = '_n', wordTrig = false }, t'ₙ'),
	s({ trig = '_k', wordTrig = false }, t'ₖ'),
	s({ trig = '_+', wordTrig = false }, t'₊'),
	s({ trig = '_-', wordTrig = false }, t'₋'),


	-- s({ trig = '[\\^]([0-9+=n-])', regTrig = true, wordTrig = false, },
	-- 	f(function(_, snip) return unicode.superscript[snip.captures[1]] end)),
	-- s({ trig = '_([0-9+=-])', regTrig = true, wordTrig = false },
	-- 	f(function(_, snip) return unicode.subscript[snip.captures[1]] end)),
	--
	-- s({ trig = 'tm', wordTrig = false }, t '™')
}
