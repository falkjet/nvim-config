vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldlevelstart = 100
vim.opt.foldtext = [[ luaeval('foldtext_function')() ]]

vim.keymap.set("n", "z0", function() vim.o.foldlevel = 0 end)
vim.keymap.set("n", "z1", function() vim.o.foldlevel = 1 end)
vim.keymap.set("n", "z2", function() vim.o.foldlevel = 2 end)
vim.keymap.set("n", "z3", function() vim.o.foldlevel = 3 end)
vim.keymap.set("n", "z4", function() vim.o.foldlevel = 4 end)
vim.keymap.set("n", "z5", function() vim.o.foldlevel = 5 end)
vim.keymap.set("n", "z6", function() vim.o.foldlevel = 6 end)
vim.keymap.set("n", "z7", function() vim.o.foldlevel = 7 end)
vim.keymap.set("n", "z8", function() vim.o.foldlevel = 8 end)
vim.keymap.set("n", "z9", function() vim.o.foldlevel = 100 end)

---@param expr string
local function isfolded(expr)
  return vim.fn.foldclosed(vim.fn.getpos(expr)[2]) ~= -1
end

-- Keymap:
vim.keymap.set('n', '<Tab>', function()
  if isfolded('.') then
    vim.api.nvim_feedkeys('zA', 'n', false)
  else
    vim.api.nvim_feedkeys('za', 'n', false)
  end
end)
vim.keymap.set('', '<c-f>', 'zA')
vim.keymap.set('n', 'zi', function()
  vim.opt.foldlevel = (vim.opt.foldlevel:get() + 1)
end)
vim.keymap.set('n', 'zI', function()
  vim.opt.foldlevel = (vim.opt.foldlevel:get() - 1)
end)
vim.keymap.set('n', 'z<Tab>', function()
  vim.opt.foldlevel = vim.opt.foldlevel:get()
end)


local bg = vim.api.nvim_get_hl(0, { name = "StatusLine" }).bg
local hl = vim.api.nvim_get_hl(0, { name = "Folded" })
hl.bg = bg
vim.api.nvim_set_hl(0, "Folded", hl)

function foldtext_function()
  local pos = vim.v.foldstart
  local line = vim.api.nvim_buf_get_lines(0, pos - 1, pos, false)[1]
  local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
  local parser = vim.treesitter.get_parser(0, lang)
  local query = vim.treesitter.query.get(parser:lang(), "highlights")

  if query == nil then
    return vim.fn.foldtext()
  end

  local tree = parser:parse({ pos - 1, pos })[1]
  local result = {}

  local line_pos = 0

  local prev_range = nil

  for id, node, _ in query:iter_captures(tree:root(), 0, pos - 1, pos) do
    local name = query.captures[id]
    local start_row, start_col, end_row, end_col = node:range()
    if start_row == pos - 1 and end_row == pos - 1 then
      local range = { start_col, end_col }
      if start_col > line_pos then
        table.insert(result, { line:sub(line_pos + 1, start_col), "Folded" })
      end
      line_pos = end_col
      local text = vim.treesitter.get_node_text(node, 0)
      if prev_range ~= nil and range[1] == prev_range[1] and range[2] == prev_range[2] then
        result[#result] = { text, "@" .. name }
      else
        table.insert(result, { text, "@" .. name })
      end
      prev_range = range
    end
  end

  return result
end
