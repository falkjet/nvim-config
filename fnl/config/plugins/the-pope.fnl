[{1 :tpope/vim-abolish}
 {1 :tpope/vim-fugitive
  :cmd [:Gedit :Gsplit :Gdiffsplit :Gvdiffsplit
	:Gread :Gwrite :Ggrep :Glgrep :GMove :GRename
	:GBrowse :Git :G]}
 {1 :tpope/vim-jdaddy
  :ft [:json :jsonc]}
 {1 :tpope/vim-repeat}
 {1 :tpope/vim-rhubarb}
 {1 :tpope/vim-sleuth
  :init (fn []
          (set vim.g.sleuth_heuristics 0)
          (set vim.g.sleuth_python_heuristics 1)
          (set vim.g.sleuth_javascript_heuristics 1))}
 {1 :tpope/vim-speeddating
  :keys ["<c-a>" "<c-x>"]}
 {1 :tpope/vim-surround
  :keys [{1 :ms 2 "<Plug>VSurround" :mode :v}
         {1 :md 2 "<Plug>Dsurround"}
         {1 :mr 2 "<Plug>Csurround"}
         {1 :ms 2 "<Plug>Ysurround"}]}
 {1 :tpope/vim-tbone
  :cmd [:Tmux :Tyank :Tput :Twrite :Tattach]}
 {1 :tpope/vim-dispatch
  :cmd [:Start :Make :Dispatch :Focus]
  :init (fn []
          (set vim.g.dispatch_no_maps 1))
  :keys [{1 "<F5>" 2 "<cmd>Dispatch<cr>"}]}]
