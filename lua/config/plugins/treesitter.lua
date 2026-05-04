-- [nfnl] fnl/config/plugins/treesitter.fnl
local function _1_()
  local function _2_()
    require("nvim-treesitter.parsers")["compila"] = {install_info = {url = "https://github.com/falkjet/tree-sitter-compila", queries = "queries"}}
    return nil
  end
  vim.api.nvim_create_autocmd("User", {pattern = "TSUpdate", callback = _2_})
  local function _3_()
    pcall(vim.treesitter.start)
    if ("fennel" ~= vim.o.ft) then
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      return nil
    else
      return nil
    end
  end
  return vim.api.nvim_create_autocmd("FileType", {callback = _3_})
end
return {{"nvim-treesitter/nvim-treesitter", branch = "main", build = ":TSUpdate", main = "nvim-treesitter", init = _1_, opts = {indent = {enable = true}, highlight = {enable = true}, incremental_selection = {enable = true, keymaps = {init_selection = "<M-o>", node_incremental = "<M-o>"}}}, lazy = false}}
