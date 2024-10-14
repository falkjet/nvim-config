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

local function in_mathzone_no_backslash(line_to_cursor, matched_trigger, _)
	local i = #line_to_cursor - #matched_trigger
	return in_mathzone() and string.sub(line_to_cursor, i, i) ~= '\\'
end

local function not_in_mathzone()
	return not in_mathzone()
end

local function ms(trig, node)
	return s({
		trig = trig,
		condition = in_mathzone_no_backslash,
		snippetType = 'autosnippet',
		wordTrig = not not trig:match('^%w')
	}, node)
end

local function autobs(word)
	return ms(word, t('\\' .. word))
end

local function var(name)
	return s({ trig = name .. '([.,?]? )', regTrig = true, condition = not_in_mathzone, snippetType = 'autosnippet' },
		{ t('$' .. name .. '$'), f(function(_, snip) return snip.captures[1] end) })
end

return {
	ms('\\negall ', t '\\neg\\forall '),
	ms('\\neg all ', t '\\neg\\forall '),
	ms('\\forall not', t '\\forall\\neg'),
	ms('ff', fmta('\\frac{<>}{<>}', { i(1), i(2) })),
	ms('tt', fmta('\\text{<>}', { i(1) })),
	ms('tie', t '\\bowtie'),
	autobs('times'),
	autobs('bot'),
	autobs('top'),
	autobs('cup'),
	autobs('cap'),
	ms('dot', t '\\cdot'),
	ms('int', fmta('\\int_{<>}^{<>}', { i(1), i(2) })),
	ms('sum', fmta('\\sum_{<>}^{<>}', { i(1), i(2) })),
	ms('inf', t '\\infty'),
	ms('...', t '\\ldots'),
	ms('not in', t '\\notin'),
	ms('notin', t '\\notin'),
	ms('<>', t '\\lozenge'),
	ms('[]', t '\\square'),
	ms('always', t '\\square'),
	ms('alw', t '\\square'),
	ms('eventually', t '\\lozenge'),
	ms('evn', t '\\lozenge'),
	ms('wuntil', t '\\mathcal{W}'),
	ms('until', t '\\mathcal{U}'),
	ms('|=', t '\\models'),
	ms('\\neg in', t '\\notin'),
	ms('\\negin', t '\\notin'),
	ms('in ', t '\\in '),
	ms('then', t '\\rightarrow'),
	ms('and', t '\\land'),
	ms('or', t '\\lor'),
	ms('not', t '\\neg'),
	ms('<=>', t '\\Leftrightarrow'),
	ms('|->', t '\\mapsto'),
	ms('->', t '\\rightarrow'),
	ms('=>', t '\\Rightarrow'),
	ms('comp', fmta('\\{<> \\mid <>\\}', { i(1), i(2) })),
	s({ trig = '([^%a])mm', wordTrig = false, regTrig = true, snippetType = 'autosnippet' },
		fmta('<>$<>$', { f(function(_, snip) return snip.captures[1] end), d(1, get_visual) })),
	ms('cal', fmta('\\mathcal{<>}', { i(1) })),
	ms('bb', fmta('\\mathbb{<>}', { i(1) })),
	ms('bf', fmta('\\mathbf{<>}', { i(1) })),
	ms('pow', fmta('\\mathcal{P}(<>)', { i(1) })),
	ms('nat', t '\\mathbb{N}'),
	ms('set', fmta('\\{<>\\}', { i(1) })),
	ms('tup', fmta('\\langle <>\\rangle', { i(1) })),
	ms('abs', fmta('\\left|<>\\right|', { i(1) })),
	ms('cc', t '\\subset'),
	ms('ce', t '\\subseteq'),
	ms('ø', t '\\emptyset'),
	ms('exi', t '\\exists'),
	ms('any', t '\\exists'),
	ms('AA', t '\\forall '),
	ms('all', t '\\forall'),
	s({ trig = 'snd', trigEngine = 'pattern', snippetType = 'autosnippet', wordTrig = false },
		t '^2'),
	s({
			trig = '(%a)_?(%d*)([,.?!:;]? ?)',
			trigEngine = 'pattern',
			condition = not_in_mathzone,
			priority = 100,
			dscr = 'math variables'
		},
		f(function(_, snip)
			local n = snip.captures[2]
			return '$' .. snip.captures[1] .. (n == '' and '' or ('_' .. n)) .. '$' .. snip.captures[3]
		end)),
	s({
			trig = '(%a)(%d)',
			trigEngine = 'pattern',
			condition = in_mathzone_no_backslash,
			snippetType = 'autosnippet',
			priority = 100,
			dscr = 'variable with number subscript'
		},
		f(function(_, snip)
			local var = snip.captures[1]
			local n = snip.captures[2]
			return var .. '_' .. n
		end)),
}
