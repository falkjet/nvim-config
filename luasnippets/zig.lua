return {
	s('print', fmta('std.debug.print("<format>\\n", .{<args>});', {
		format = i(1),
		args = i(2),
	})),
}
