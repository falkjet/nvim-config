

function stars(args)
	local len = math.floor(args[1][1]:len() / 2)
	return (" *"):rep(len)
end

local function even_space(args)
	return args[1][1]:len() % 2 == 0 and " " or ""
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

	s('sbanner', fmta([[
		/*<> * *
		 * <><> *
		 *<> * */
	]], { f(stars, 1), i(1), f(even_space, 1), f(stars, 1) }))
}
