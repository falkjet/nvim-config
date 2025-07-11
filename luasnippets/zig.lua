local function dashes(args)
  return ("-"):rep(args[1][1]:len())
end

return {
	s('banner', fmta([[
		//-<>-//
		// <> //
		//-<>-//
	]], { f(dashes, 1), i(1), f(dashes, 1) })),
	s('print', fmta('std.debug.print("<format>\\n", .{<args>});', {
		format = i(1),
		args = i(2),
	})),
}
