{1 :folke/snacks.nvim
 :priority 1000
 :lazy false
 :opts (fn []
	 {:bigfile {:enabled true}
          :dashboard {:enabled true}
          :explorer {:enabled true}
	  :image {:enabled true}
          :indent {:enabled false}
          :input {:enabled true}
          :notifier {:enabled true}
          :picker {:enabled true}
          :quickfile {:enabled true}
          :scope {:enabled true}
          :scroll {:enabled true}
          :statuscolumn {:enabled true}
          :words {:enabled true}})
 :config (fn [spec opts]
	   (let [snacks (require :snacks)]
	     (snacks.setup opts)))
 :keys [["<leader>f" "<cmd>lua require'snacks'.picker.files()<cr>" "File Picker"]
	["<leader>sg" "<cmd>lua require'snacks'.picker.grep()<cr>" "Live grep"]
	["<leader>," "<cmd>lua require'snacks'.picker.buffers()<cr>" "Buffers"]]}
