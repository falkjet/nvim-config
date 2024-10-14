local languages = {
	go = {
		query_source = [[ (call_expression function:
      (selector_expression
       field: (field_identifier)@field
              (#match? @field "^(Queryx?|(Must)?Exec(ute)?)$"))
       arguments: (argument_list (raw_string_literal) @sql))
    ]],
		open_quote_pattern = '[`"]',
		close_quote_pattern = '[`"]',
	},
	rust = {
		query_source = [[
      (macro_invocation
        macro: (scoped_identifier
          path: (identifier) @_path (#eq? @_path "sqlx")
          name: (identifier) @_name (#eq? @_name "query"))
        (token_tree
          (raw_string_literal) @sql))
    ]],
		open_quote_pattern = 'r#+"',
		close_quote_pattern = '"#+',
	}
}


local function get_root(bufnr, lang)
	local parser = vim.treesitter.get_parser(bufnr, lang, {})
	local tree = parser:parse()[1]
	return tree:root()
end

---@param source string
---@return table
local function format_sql(source)
	local lines = {}
	local jobid = vim.fn.jobstart('pg_format', {
		stdin = 'pipe',
		stdout_buffered = true,
		on_stdout = function(_, l) lines = l end
	})
	if jobid == 0 then
		error()
	end


	vim.fn.chansend(jobid, source)
	vim.fn.chanclose(jobid, 'stdin')
	vim.fn.jobwait({ jobid })
	while lines[#lines] == '' do
		lines[#lines] = nil
	end

	return lines
end

local function apply_changes(bufnr, changes)
	for _, change in ipairs(changes) do
		vim.api.nvim_buf_set_lines(
			bufnr, change.start, change.final, false, change.formatted)
	end
end

local function before_and_after_node(bufnr, node)
	local start_line, start_col, end_line, end_col = node:range()
	local before = vim.api.nvim_buf_get_lines(
		bufnr, start_line, start_line + 1, true)[1]:sub(1, start_col)
	local after = vim.api.nvim_buf_get_lines(
		bufnr, end_line, end_line + 1, true)[1]:sub(end_col + 1)
	return before, after
end

local function make_replacement(before, after, lines)
	local indentation = before:match("^%s*")
	local replacement = {}
	replacement[1] = before
	for idx, line in ipairs(lines) do
		replacement[idx + 1] = indentation .. '    ' .. line
	end
	replacement[#replacement + 1] = indentation .. after
	return replacement
end


local function split_quote_content(open_pattern, close_pattern, text)
	open_pattern = '^' .. open_pattern
	close_pattern = close_pattern .. '$'
	local open = text:match(open_pattern)
	local close = text:match(close_pattern)
	local text = text:match(open_pattern .. '(.*)' .. close_pattern)
	return open, text, close
end


---comment
---@param bufnr number
---@param embedded_sql_query any
---@param language string
---@param open_quoute_pattern string
---@param close_quote_pattern string
local function generic_format_embedded_sql(bufnr, embedded_sql_query,
																					 language,
																					 open_quoute_pattern,
																					 close_quote_pattern)
	local root = get_root(bufnr, language)
	local changes = {}
	for id, node in embedded_sql_query:iter_captures(root, bufnr, 0, -1) do
		local name = embedded_sql_query.captures[id]
		if name == 'sql' then
			local start_line, _, end_line, _ = node:range()
			local source = vim.treesitter.get_node_text(node, bufnr)
			local before, after = before_and_after_node(bufnr, node)

			local open, quoted, close = split_quote_content(
				open_quoute_pattern, close_quote_pattern, source)
			local formatted = format_sql(quoted)
			formatted = make_replacement(before .. open, close .. after, formatted)

			table.insert(changes, 1, {
				start = start_line,
				final = end_line + 1,
				formatted = formatted,
			})
		end
	end

	apply_changes(bufnr, changes)
end

return function(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	local ft = vim.bo[bufnr].filetype
	local language = languages[ft]
	if language == nil then
		-- vim.notify('cant format sql in ' .. ft .. ' file')
		return
	end

	if language.query == nil then
		language.query = vim.treesitter.query.parse(
			language.syntax or ft, language.query_source)
	end

	generic_format_embedded_sql(
		bufnr, language.query,
		language.syntax or ft,
		language.open_quote_pattern,
		language.close_quote_pattern
	)
end
