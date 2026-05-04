-- [nfnl] fnl/config/plugins/conjure.fnl
local function _1_()
  vim.g["conjure#filetypes"] = {"clojure", "fennel"}
  return nil
end
return {{"clojure-vim/vim-jack-in", dependencies = {"vim-dispatch"}, cmd = {"Boot", "Clj", "Lein"}}, {"Olical/conjure", ft = {"fennel", "clojure"}, dependencies = {"PaterJason/cmp-conjure"}, init = _1_, keys = {{"<leader>er", "<cmd>ConjureEvalRootForm<cr>"}, {"<leader>eb", "<cmd>ConjureEvalFile"}}}}
