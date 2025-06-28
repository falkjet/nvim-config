
local function dashes(args)
  return ("-"):rep(args[1][1]:len())
end

return {
	s('banner', fmta([[
		//-<>-//
		// <> //
		//-<>-//
	]], { f(dashes, 1), i(1), f(dashes, 1) })),
}
