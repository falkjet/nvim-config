local cond_obj = require("luasnip.extras.conditions")
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmta = require("luasnip.extras.fmt").fmta

local function iscallable(v)
	return (type(v) == 'function' or --
		type(v) == 'table' and (getmetatable(v) or {}).__call) and true
end

local M = {}
function M.capture(n)
	return f(function(_, snip) return snip.captures[n] end)
end

--- Usage: auto(pattern, template, [args...], [condition])
--- Optional arguments in square brackets. Args can both snippet nodes, and
--- numbers. Number arguments are replaced by the captures in the pattern
function M.auto(trig, template, ...)
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
	return s({
		trig = trig,
		regTrig = true,
		snippetType = 'autosnippet',
		wordTrig = false,
		condition = condition,
		hidden = true,
	}, fmta(template, args))
end

function M.pattern(p)
	return cond_obj.make_condition(function(line_to_string)
		return line_to_string:match(p)
	end)
end

return M
