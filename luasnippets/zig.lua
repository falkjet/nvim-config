local capture = require 'config.snippetutils'.capture

local function copy(args)
	return args[1]
end

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
	]], { f(stars, 1), i(1), f(even_space, 1), f(stars, 1) })),

	s('build', fmta([[
		const std = @import("std");

		pub fn build(b: *std.Build) void {
			const target = b.standardTargetOptions(.{});
			const optimize = b.standardOptimizeOption(.{});

			<>
		}
	]], { i(0) })),

	s('exe', fmta([[
		const <> = b.addExecutable(.{
			.name = "<>",
			.root_module = b.createModule(.{
				.root_source_file = b.path("<>"),
				.target = target,
				.optimize = optimize,
			}),
		});

		b.installArtifact(<>);
	]], { i(1, "exe"), i(2), i(3, "src/main.zig"), f(copy, 1) })),

	s('run', fmta([[
		const run_cmd = b.addRunArtifact(<>);
		run_cmd.step.dependOn(b.getInstallStep());
		if (b.args) |args| { run_cmd.addArgs(args); }

		const run_step = b.step("run", "Run the program");
		run_step.dependOn(&run_cmd.step);
	]], { i(1, "exe") })),

	s('gpa', fmta([[
		var gpa = std.heap.GeneralPurposeAllocator(.{}){};
		defer std.debug.assert(gpa.deinit() == .ok);
		const allocator = gpa.allocator();
	]], {})),

	s('print', fmta([[
		std.debug.print("<>", .{ <> });
		<>
	]], { i(1), i(2), i(0) })),

	-- Write structs like in c (doesn't fix semicolon)
	s({
		trig = 'struct (%a*) ', regTrig = true,
		snippetType = 'autosnippet', wordTrig = false
	}, fmta([[
		const <> = struct
	]], { f(function(_, snip) return snip.captures[1] end) })),

	-- Write for loops like python for loops with parens
	s({
		trig = 'for (%a*) in (.*) {',
		regTrig = true,
		snippetType = 'autosnippet',
		wordTrig = false,
	}, fmta([[
		for (<>) |<>| {
	]], { capture(2), capture(1) }))
}

