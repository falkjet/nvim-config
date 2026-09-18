

(local dashboard-keys
  [{:icon " "
    :key "f"
    :desc "Find File"
    :action ":lua Snacks.dashboard.pick('files')" } 
   {:icon " "
    :key "n"
    :desc "New File"
    :action ":ene | startinsert" } 
   {:icon " "
    :key "g"
    :desc "Find Text"
    :action
    ":lua Snacks.dashboard.pick('live_grep')" } 
   {:icon " "
    :key "r"
    :desc "Recent Files"
    :action ":lua Snacks.dashboard.pick('oldfiles')" } 
   {:icon " "
    :key "c"
    :desc "Config"
    :action ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" } 
   {:icon " "
    :key "s"
    :desc "Restore Session"
    :section "session" } 
   {:icon "󰒲 "
    :key "L"
    :desc "Lazy"
    :action ":Lazy"} 
   {:icon " "
    :key "q"
    :desc "Quit"
    :action ":qa"}
   {:icon " "
    :key "w"
    :desc "Vim Wiki"
    :action ":VimwikiIndex"}])


{1 :folke/snacks.nvim
 :priority 1000
 :lazy false
 :opts (fn []
         {:bigfile {:enabled true}
          :dashboard {:enabled true
                      :preset {:keys dashboard-keys}
                      :sections [{:section :header}
                                 {:section :keys
                                  :gap 1
                                  :padding 1}
                                 {:section :startup}]}
          :explorer {:enabled true :replace_netrw false}
          :image {:enabled true}
          :indent {:enabled false}
          :input {:enabled true}
          :notifier {:enabled true}
          :picker {:enabled true}
          :quickfile {:enabled true}
          :scope {:enabled true}
          :scroll {:enabled true}
          :statuscolumn {:enabled true
                         :right [:git]}
          :words {:enabled true}})
 :config (fn [spec opts]
           (let [snacks (require :snacks)]
             (snacks.setup opts)))
 :keys [["<leader>f" "<cmd>lua require'snacks'.picker.files()<cr>" "File Picker"]
        ["<leader>c" "<cmd>lua Snacks.picker.files {cwd = vim.fn.stdpath('config')}<cr>"]
        ["<leader>C" "<cmd>lua Snacks.picker.grep {cwd = vim.fn.stdpath('config')}<cr>"]
        ["<leader>sg" "<cmd>lua require'snacks'.picker.grep()<cr>" "Live grep"]
        ["<leader>," "<cmd>lua require'snacks'.picker.buffers()<cr>" "Buffers"]
        ["<leader>sh" "<cmd>lua require'snacks'.picker.help()<cr>" "Help"]]}
