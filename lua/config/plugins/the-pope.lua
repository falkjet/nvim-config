-- [nfnl] fnl/config/plugins/the-pope.fnl
local function _1_()
  vim.g.sleuth_heuristics = 0
  vim.g.sleuth_python_heuristics = 1
  vim.g.sleuth_javascript_heuristics = 1
  return nil
end
local function _2_()
  vim.g.dispatch_no_maps = 1
  return nil
end
return {{"tpope/vim-abolish"}, {"tpope/vim-fugitive", cmd = {"Gedit", "Gsplit", "Gdiffsplit", "Gvdiffsplit", "Gread", "Gwrite", "Ggrep", "Glgrep", "GMove", "GRename", "GBrowse", "Git", "G"}}, {"tpope/vim-jdaddy", ft = {"json", "jsonc"}}, {"tpope/vim-repeat"}, {"tpope/vim-rhubarb"}, {"tpope/vim-sleuth", init = _1_}, {"tpope/vim-speeddating", keys = {"<c-a>", "<c-x>"}}, {"tpope/vim-surround", keys = {{"ms", "<Plug>VSurround", mode = "v"}, {"md", "<Plug>Dsurround"}, {"mr", "<Plug>Csurround"}, {"ms", "<Plug>Ysurround"}}}, {"tpope/vim-tbone", cmd = {"Tmux", "Tyank", "Tput", "Twrite", "Tattach"}}, {"tpope/vim-dispatch", cmd = {"Start", "Make", "Dispatch", "Focus"}, init = _2_, keys = {{"<F5>", "<cmd>Dispatch<cr>"}}}}
