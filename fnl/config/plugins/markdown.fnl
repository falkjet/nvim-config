[;{1 :MeanderingProgrammer/render-markdown.nvim
 ; :dependencies [:nvim-treesitter/nvim-treesitter]
 ; :opts {}}
 {1 :vimwiki/vimwiki
  :init (fn []
          (set vim.g.vimwiki_list
            [{:path "~/Documents/Vim Wiki"
              :syntax :markdown
              :ext :md}])
          (set vim.g.vimwiki_key_mappings
            {:headers 0}))}]
 []
