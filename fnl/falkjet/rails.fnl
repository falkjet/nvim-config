(fn get-ts-parser [buffer lang]
    (vim.treesitter.get_parser buffer lang {}))

(fn get-ts-root [buffer lang]
  (local parser (get-ts-parser buffer lang))
  (local tree (. (parser:parse) 1))
  (tree:root))

(fn get-cursor [win]
  "Get cursor as zero indexed line and column"
  (let [[line col] (vim.api.nvim_win_get_cursor win)]
    [(- line 1) col]))

(fn get-ts-node-at-cursor [win lang node]
  (local buffer (vim.api.nvim_win_get_buf win))
  (local [line col] (get-cursor win))
  (local node (or node (get-ts-root buffer)))
  (node:named_descendant_for_range line col line col))

(fn get-ts-path-to-cursor [win lang]
  (local buffer (vim.api.nvim_win_get_buf win))
  (var node (get-ts-root buffer))
  (local target (get-ts-node-at-cursor win lang node))
  (local path [])
  (while (not= node target)
    (set node (node:child_with_descendant target))
    (table.insert path node))
  path)

(fn to-camel [name]
  (local result (string.gsub name "[_-](%a)" (fn [c] (c:upper))))
  result)

(fn to-pascal [name]
  (local name (to-camel name))
  (if (= name "")
    ""
    (.. (string.upper (string.sub name 1 1))
        (string.sub name 2))))

(fn controller-info [win]
  (local buffer (vim.api.nvim_win_get_buf win))
  (local filename (vim.api.nvim_buf_get_name buffer))
  (local (project-path name) (string.match filename "(.*)/app/controllers/(.*)_controller.rb"))
  (when (and project-path name)
    (local [class _body method] (get-ts-path-to-cursor win))
    (when (and class (= (class:type) :class) (or (not method) (= (method:type) :method)))
      (local class-name (vim.treesitter.get_node_text (. (class:field :name) 1) buffer))
      (local method-name (and method (vim.treesitter.get_node_text (. (method:field :name) 1) buffer)))
      (local class-controller-name (class-name:match "(.*)Controller$"))
      (when  (and class-controller-name (=  class-controller-name (to-pascal name)))
        {:project project-path :controller name : filename :action method-name}))))


(fn view-info [win]
  (local buffer (vim.api.nvim_win_get_buf win))
  (local filename (vim.api.nvim_buf_get_name buffer))
  (local (project controller action) (string.match filename "(.*)/app/views/(.*)/(.*).html.erb"))
  (when (and project controller action)
    {: project : controller : action}))

(vim.api.nvim_create_user_command
  :RailsView
  (fn []
    (local controller-info (controller-info 0))
    (local view-info (view-info 0))
    (if
      ;; Switch from controller to  view
      (and controller-info controller-info.action)
      (let [info controller-info]
        (local view-file (.. info.project "/app/views/" info.controller "/" info.action ".html.erb"))
        (vim.cmd.edit view-file))
      
      ;; Switch from view to controller
      view-info
      (let [info view-info]
        (local controller-file (.. info.project "/app/controllers/" info.controller "_controller.rb"))
        (vim.cmd.edit controller-file))))
  {})
