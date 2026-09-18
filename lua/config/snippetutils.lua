local cond_obj = require("luasnip.extras.conditions")
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmta = require("luasnip.extras.fmt").fmta
local fmt = require("luasnip.extras.fmt").fmt

local function iscallable(v)
	return (type(v) == 'function' or --
		type(v) == 'table' and (getmetatable(v) or {}).__call) and true
end

local M = {}
function M.capture(n)
	return f(function(_, snip) return snip.captures[n] end)
end

function M.magic(opts, trig, template, ...)
	local args = { ... }
	local condition = nil
	if iscallable(args[#args]) then
		condition = args[#args]
		args[#args] = nil
	end
	for i = 1, #args do
		if type(args[i]) == 'number' then
			args[i] = M.capture(args[i])
		end
	end
	
	local format = fmta
	if opts.curly then
		format = fmt
	end
	
	return s({
		trig = trig,
		condition = condition,
		regTrig = opts.regTrig,
		snippetType = opts.snippetType,
		wordTrig = opts.wordTrig,
		hidden = opts.hidden,
	}, format(template, args))
end

function M.custom_magic(opts)
	return function(trig, template, ...)
		return M.magic(opts, trig, template, ...)
	end
end

--- Usage: auto(pattern, template, [args...], [condition])
--- Optional arguments in square brackets. Args can both snippet
--- nodes, and numbers. Number arguments are replaced by the
--- captures in the pattern
M.auto = M.custom_magic {
	regTrig = true,
	snippetType = 'autosnippet',
	wordTrig = false,
	hidden = true,
}

M.auto_c = M.custom_magic {
	regTrig = true,
	snippetType = 'autosnippet',
	wordTrig = false,
	hidden = true,
	curly = true,
}

M.tab = M.custom_magic {
	regTrig = true,
	wordTrig = false,
	hidden = true,
}

M.tab_c = M.custom_magic {
	regTrig = true,
	wordTrig = false,
	hidden = true,
	curly = true,
}

function M.pattern(p)
	return cond_obj.make_condition(function(line_to_string)
		return line_to_string:match(p)
	end)
end

return M
