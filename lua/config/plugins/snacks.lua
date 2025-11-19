-- [nfnl] fnl/config/plugins/snacks.fnl
local function _1_()
  return {bigfile = {enabled = true}, dashboard = {enabled = true}, explorer = {enabled = true, replace_netrw = false}, image = {enabled = true}, indent = {enabled = false}, input = {enabled = true}, notifier = {enabled = true}, picker = {enabled = true}, quickfile = {enabled = true}, scope = {enabled = true}, scroll = {enabled = true}, statuscolumn = {enabled = true}, words = {enabled = true}}
end
local function _2_(spec, opts)
  local snacks = require("snacks")
  return snacks.setup(opts)
end
return {"folke/snacks.nvim", priority = 1000, opts = _1_, config = _2_, keys = {{"<leader>f", "<cmd>lua require'snacks'.picker.files()<cr>", "File Picker"}, {"<leader>sg", "<cmd>lua require'snacks'.picker.grep()<cr>", "Live grep"}, {"<leader>,", "<cmd>lua require'snacks'.picker.buffers()<cr>", "Buffers"}}, lazy = false}
