local pattern = require 'config.snippetutils'.pattern
local auto = require 'config.snippetutils'.auto

return {
	-- Write let instae of local
	auto('let ', 'local ', pattern '^%s*let $'),

	-- Write +=, *=, /= or -=.
	auto('^(%s*)(.*) ([+*/-])= ', '<><> = <> <> ', 1, 2, 2, 3),

	-- Write func instead of function
	auto('func[(]', 'function(', pattern '%Afunc[(]$'),
	auto('func (%a+)[(]', 'function <>(', 1, pattern '%Afunc %a+[(]$'),
	auto('func ', 'local function <>\nend', i(0), pattern '^func '),
	auto('local function (%a+)([.:])', 'function <><>', 1, 2),
}
