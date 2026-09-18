function run(...)
	local result = vim.system({...}, {text = true}):wait()
	return result.stdout:match("(.*)\n")
end

run('git')

return {
	s('today', f(function() return vim.fn.strftime('%F') end)),
	s('me', f(function()
		local name = run('git', 'config', 'user.name')
		local email = run('git', 'config', 'user.email')
		return name .. " <" .. email .. ">"
	end)),
}
