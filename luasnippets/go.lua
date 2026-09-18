local pattern = require 'config.snippetutils'.pattern
local auto = require 'config.snippetutils'.auto

local is_comment = pattern '^%s*//'


local function g(n)
	return f(function(_, snip)
		return snip.captures[n]
	end)
end

local function dashes(args)
  return ("-"):rep(args[1][1]:len())
end

return {
	auto('for (%a+) in (.*) {', 'for _, <> := range <> {', 1, 2),
	auto('for (%a+), (%a+) in (.*) {', 'for <>, <> := range <> {', 1, 2, 3),
	auto('struct (%a*) ', 'type <> struct ', 1, pattern '^%s*struct'),
	auto('interface (%a*) ', 'type <> interface ', 1, pattern '^%s*interface'),
	auto('(.*) := (.*)%.map (%a*): (.*) {', '<> := make([]<>, len(<>))\nfor <>, x := range <> {', 1, 4, 2, 3, 2),
	auto('map (.*) [-]> (%a*) (.*) {', '<> := make([]<>, len(<>))\nfor i, x := range <> {', 2, 3, 1, 1),
	s({ trig = '^(%s*)([^%s].*).app', trigEngine = 'pattern', hidden = true },
		fmt('{1}{2} = append({2}, {3})', { g(1), g(2), i(1) })),
	s('banner', fmta([[
		//-<>-//
		// <> //
		//-<>-//
	]], { f(dashes, 1), i(1), f(dashes, 1) })),
}
