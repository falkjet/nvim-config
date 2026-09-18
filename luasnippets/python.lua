local pattern = require 'config.snippetutils'.pattern
local auto = require 'config.snippetutils'.auto

return {
	auto('struct (%a*):', '@dataclass\nclass <>:', 1, pattern '^%s*struct'),
}
