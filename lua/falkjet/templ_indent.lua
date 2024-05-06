local tsquery = require("vim.treesitter.query")

vim.api.nvim_create_augroup("dev", {
  clear = true,
})
vim.api.nvim_create_autocmd("BufWritePost", {
  group = "dev",
  pattern = "*.lua",
  callback = function()
    vim.cmd.luafile(vim.fn.expand("%"))
  end
})

vim.api.nvim_create_autocmd("BufLeave", {
  group = "dev",
  pattern = "*.lua",
  callback = function()
    vim.cmd 'w'
  end
})

tsquery.set("templ", "indents", [[
(element) @indent.begin
(tag_end) @indent.branch

(component_block) @indent.begin
(component_block
  "}" @indent.end @indent.branch .)

(conditional_attribute_block) @indent.begin

(attribute
 value: (expression) @indent.begin)

(tag_start
  ">" @indent.branch .)
]])
