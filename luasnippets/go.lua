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



---@param node TSNode
---@return string
local function node_text(node)
	return vim.treesitter.get_node_text(node, vim.api.nvim_get_current_buf())
end


---@param n TSNode | nil
---@return TSNode | nil
local function get_function(n)
	if n == nil then
		n = vim.treesitter.get_node()
	end
	while n do
		if n:type() == 'function_declaration' then
			break
		end
		n = n:parent()
	end
	return n
end


---@param n TSNode | nil
---@return TSNode | nil
local function get_result(n)
	local fun = get_function(n)
	if fun == nil then
		return nil
	end
	---@diagnostic disable-next-line: undefined-field
	return fun:field 'result'[1]
end


local function children(n)
	local child_count = n:child_count()
	local i = 0
	return function()
		if i >= child_count then
			return nil
		end
		local child = n:child(i)
		i = i + 1
		return child
	end
end


function decode_result(node)
	local result = get_result(node)
	if result == nil then
		return {}, {}
	end
	local names = {}
	local types = {}
	for child in children(result) do
		if child:type() ~= 'parameter_declaration' then
			goto continue
		end
		local found_name = false
		local type_ = child:field 'type'[1]
		for _, name in ipairs(child:field 'name') do
			found_name = true
			names[#names + 1] = node_text(name)
			types[#types + 1] = type_
		end
		if not found_name then
			types[#types + 1] = type_
		end
		::continue::
	end

	return names, types
end

local function g(n)
	return f(function(_, snip)
		return snip.captures[n]
	end)
end

local function spaceif(args)
	return args[1][1] == '' and '' or ' '
end


local function smartparen(args, parent)
	return sn(nil, {
		f(function(args) return string.match(args[1][1], '^%a*$') == nil and '(' or '' end, 1),
		i(1),
		f(function(args) return string.match(args[1][1], '^%a*$') == nil and ')' or '' end, 1),
		f(spaceif, 1),
	})
end

local function dashes(args)
  return ("-"):rep(args[1][1]:len())
end

return {
	s('banner', fmta([[
		//-<>-//
		// <> //
		//-<>-//
	]], { f(dashes, 1), i(1), f(dashes, 1) })),

	s({ trig = 'struct (%a*) ', regTrig = true, snippetType = 'autosnippet', wordTrig = false },
		fmta("type <> struct ", { f(function(_, snip) return snip.captures[1] end) })),
	s({ trig = 'interface (%a*) ', regTrig = true, snippetType = 'autosnippet', wordTrig = false },
		fmta("type <> interface ", { f(function(_, snip) return snip.captures[1] end) })),
	s({ trig = '^(%s*)([^%s].*).app', trigEngine = 'pattern' },
		fmt('{1}{2} = append({2}, {3})', { g(1), g(2), i(1) })),
	s({ trig = 'fwd' }, fmta([[
    if err != nil {
    <>return <>
    }
  ]], { t '\t', d(1, function()
		local result = get_result()
		if result == nil then
			return sn(nil, i(1, "err"))
		end
		local nodes = {}
		local names, _ = decode_result()
		for j, name in ipairs(names) do
			if #nodes ~= 0 then
				nodes[#nodes + 1] = t ', '
			end
			nodes[#nodes + 1] = i(j, name)
		end
		return sn(nil, nodes)
	end) })),
	s({ trig = 'fun' }, fmta([[
    // <>
    func <>(<>) <>{
    <><>
    }
  ]], { i(4), i(1), i(2), d(3, smartparen), t '\t', i(0) })),
	s({ trig = 'hf' }, fmta([[
    func <>(w http.ResponseWriter, r *http.Request) {
        <>
    }
  ]], { i(1), i(0) })),
}
