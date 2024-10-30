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

local function get_cursor_0ind()
	local c = vim.api.nvim_win_get_cursor(0)
	c[1] = c[1] - 1
	return c
end

return {
	-- function
	s({ trig = "fun" }, fmta([[
    function<><>(<>)
      <>
    end
  ]], { f(spaceif, 1), i(1), i(2), i(0) })),

	-- Local function
	s({ trig = "fnl" }, fmta([[
    local function <>(<>)
      <>
    end
  ]], { i(1), i(2), i(0) })),


	-- Use end instead of {}
	s({
		trig = '(function.*[(].*[)]) {',
		trigEngine = 'pattern',
		wordTrig = false,
		snippetType = 'autosnippet',
		resolveExpandParams = function(snip, line, trig, capt)
			local pos = get_cursor_0ind()
			local line = vim.api.nvim_get_current_line()
			return {
				clear_region = {
					from = { pos[1], 0 },
					to = { pos[1], #line }
				}
			}
		end
	}, fmta('<> <>end', { f(function(_, snip)
		return snip.captures[1]
	end), i(0) }))
}
