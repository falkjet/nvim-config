;; Lua compatibility fix
(set unpack (or table.unpack unpack))
(set table.unpack (or table.unpack unpack))

(fn nmap [key action description]
    (vim.keymap.set :n key action {:desc description}))
(fn cmap [key action description]
    (vim.keymap.set :c key action {:desc description}))

(import-macros {: on-ft} :macros)

;;;;;;;;;;;;;
;; Options ;;
;;;;;;;;;;;;;
(set vim.g.mapleader " ")
(set vim.g.maplocalleader "\\")
(set vim.o.hlsearch false)
(set vim.wo.number true)
(set vim.wo.relativenumber true)
(set vim.o.mouse :a)
(set vim.opt.showtabline 2)
(set vim.o.clipboard :unnamedplus)
(set vim.o.breakindent true)
(set vim.o.undofile true)
(set vim.o.ignorecase true)
(set vim.o.smartcase true)
(set vim.wo.signcolumn :yes)
(set vim.o.updatetime 250)
(set vim.o.timeoutlen 300)
(set vim.o.completeopt "menuone,noselect")
(set vim.o.termguicolors true)
(set vim.o.showtabline 0)
(set vim.o.laststatus 0)
(set vim.o.tags "~/.vim/system.tags,tags")


;;;;;;;;;;;;;;;;;;;;;
;; Version Control ;;
;;;;;;;;;;;;;;;;;;;;;

;; Show changed lines
((. (require :gitsigns) :setup))

;; Git keybinds
(nmap "<leader>gd" "<cmd>Gvdiffsplit<cr>" "[D]iff current file")
(nmap "<leader>gs" "<cmd>Gitsigns stage_hunk<cr>" "[G]it [S]tage hunk")
(nmap "<leader>gp" "<cmd>Gitsigns preview_hunk<cr>" "[G]it [S]tage hunk")
(nmap "<leader>gr" "<cmd>Gitsigns preview_hunk<cr>" "[G]it [S]tage hunk")
(nmap "<leader>gS" "<cmd>G stage %<cr>" "[G]it [S]tage current file")
(nmap "<leader>gc" "<cmd>G commit<cr>" "[G]it [C]ommit")
(nmap "]g" "<cmd>Gitsigns next_hunk<cr>")
(nmap "[g" "<cmd>Gitsigns prev_hunk<cr>")

;;;;;;;;;;;;;;;;;;;
;; Configuration ;;
;;;;;;;;;;;;;;;;;;;

((. (require :neoconf) :setup))
((. (require :neodev) :setup))


;;;;;;;;;;;;;;;;;;;
;; User Interfae ;;
;;;;;;;;;;;;;;;;;;;

;; Show keybind help
((. (require :which-key) :setup))

(let [leap (require :leap)]
  (leap.create_default_mappings))

;; Vim tmux navigator
(vim.keymap.set [:n :i :t] "<m-h>" "<cmd>TmuxNavigateLeft<cr>" {:desc "Left Pane"})
(vim.keymap.set [:n :i :t] "<m-j>" "<cmd>TmuxNavigateDown<cr>" {:desc "Below Pane"})
(vim.keymap.set [:n :i :t] "<m-k>" "<cmd>TmuxNavigateUp<cr>" {:desc "Above Pane"})
(vim.keymap.set [:n :i :t] "<m-l>" "<cmd>TmuxNavigateRight<cr>" {:desc "Right Pane"})

;; Oil file manager
(let [{: setup : open} (require :oil)]
  (setup {:win_options {:wrap false}
          :skip_confirm_for_simple_edits true})
  (nmap "-" open "Open Oil")
  (vim.api.nvim_create_autocmd
    :UIEnter
    {:pattern "*"
     :nested true
     :callback (fn [] (when (= 0 (length (vim.fn.argv)))
                        (open)))}))

;; Telescope
(require :falkjet.telescope)

;; Theming
(require :falkjet.theme)

;; Git worktree stuff
((. (require :git-worktree) :setup) {:autopush false})
(let [telescope (require :telescope)
      git-worktree (require :git-worktree)
      make-command vim.api.nvim_create_user_command]
  (git-worktree.setup {:autopush false})
  (telescope.load_extension :git_worktree)
  (make-command
    :CreateWorktree
    (fn [] (telescope.extensions.git_worktree.create_git_worktree)) {})
  (make-command
    :Worktree
    (fn [] (telescope.extensions.git_worktree.git_worktrees)) {}))


;; Keymap tweaks
;; - quickfix list
(nmap "[f" "<cmd>cprev<cr>" "Previous item in quickfix list")
(nmap "]f" "<cmd>cnext<cr>" "Next item in quickfix list")

;; One Handed
(nmap "<C-c>" :: "")
(cmap "<C-c>" "<cr>" "")

;; Conceal (see help conceallevel)
(set vim.o.conceallevel 2)
(vim.keymap.set
  :n "<leader>tc"
  (fn [] (set vim.opt.conceallevel
              (if (= 2 (vim.opt.conceallevel:get)) 0 2))))

;; Diagnostics
(let [d vim.diagnostic]
  (nmap "[d" d.goto_prev "Go to previous diagnostic message")
  (nmap "]d" d.goto_next "Go to next diagnostic message")
  (nmap "<leader>e" d.open_float "Open floating diagnostic message")
  (nmap "<leader>q" d.setloclist "Open diagnostics list"))

(fn hide-diagnostics []
  (vim.diagnostic.config
    {:virtual_text false
     :signs false
     :underline false}))

(fn show-diagnostics []
  (vim.diagnostic.config
    {:virtual_text true
     :signs true
     :underline true}))

(nmap "<leader>dh" hide-diagnostics "Hide Diagnostics")
(nmap "<leader>ds" show-diagnostics "Show Dianostics")

(hide-diagnostics) ; TODO: toggle diagnostics
 
;; Harpoon
(require :falkjet.harpoon)

;; Fidget (lsp status thingy)
(let [{: setup} (require :fidget)]
  (setup {}))


;; Folding
(require :falkjet.folding)

;;;;;;;;;;;;;
;; Editing ;;
;;;;;;;;;;;;;
;; Automatic parenthesis
(let [au (require :ultimate-autopair)]
  (au.setup
    {:cr {:enable true
          :autoclose true
          :conf {:cond (lambda [fun]
                           (and (not= vim.o.ft :fennel)
                                (not (fun.in_lisp))))}}}))

;; Snippets
(require :falkjet.snippets)

;; Autocomplete
(require :falkjet.autocomplete)

;; Surround
(nmap :mr "<Plug>Csurround" "Surround [R]eplace")
(nmap :md "<Plug>Dsurround" "Surround [D]elete")
(vim.keymap.set :v :ms "<Plug>VSurround" {:desc "[S]urround"})

;; Keymap tweaks
(vim.keymap.set :i "jj" "<Esc>")

;; Fold and unfold list, scopes, ...
(let [{: setup} (require :treesj)
      {: helpers} (require :treesj.langs.utils)
      is-2nd-child
      (fn [node] (local parent (node:parent)) (= (parent:child 2) node))]
  (setup {:langs
          {:templ
           {:block {}
            :argument_list {:both {:separator ","
                                   }
                            :split {:last_separator true}}
            :parameter_list {:both {:separator ","} :split {:last_separator true}}
            :import_spec_list {}
            :component_block {}
            :script_block {}
            :element {}
            :tag_start {:both
                        {:omit [is-2nd-child]}}
            :function_declaration {:target_nodes [:block]}
            :func_literal {:target_nodes [:block]}}
           :zig
           {:initializer_list {:both {:separator ","} :split {:last_separator true}}
            :struct_initializer {:target_nodes [:initializer_list]}
            :anonymous_struct_initializer {:target_nodes [:initializer_list]}
            :call_expression {:both {:separator ","
                                     :omit [is-2nd-child]}}
            :block {}
            :parameters {:both {:separator ","} :split {:last_separator true}}}
           :odin
           {:tuple_type {:both {:separator ","} :split {:last_separator true}}
            :parameters {:both {:separator ","} :split {:last_separator true}}
            :call_expression {:both {:separator ","} :split {:last_separator true}}}}}))

(vim.defer_fn
  (fn []
    (vim.cmd.Abolish "stirng" "string")
    (vim.cmd.Abolish "skirve" "skrive")) 0)

;; Comment
(let [{: setup} (require :Comment)
      {:set set-ft} (require :Comment.ft)]
  (setup)
  (set-ft :fennel ";; %s")
  (set-ft :scheme ";; %s")
  (set-ft :nasm ";; %s")
  (set-ft :templ "// %s"))

;; useful commands
(vim.api.nvim_create_user_command :FixTrailingSpace "%s/\\s\\+$//g" {})
(vim.api.nvim_create_user_command :MakeExecutable "w | !chmod +x %" {})

;;;;;;;;;;;;;;;;;;;;;;
;; Language Support ;;
;;;;;;;;;;;;;;;;;;;;;;
(vim.filetype.add
  {:extension
   {:cshtml :razor
    :maude  :maude
    :templ  :templ
    :tmpl   :gohtmltmpl
    :bqn    :bqn}})

;; Decent indent options
(set vim.opt.sw 4)
(set vim.opt.ts 4)
(set vim.opt.et true)

;; Run and debug
(require :falkjet.run)
(require :falkjet.dap)

;; Lsp
(require :falkjet.lsp)

;; Treesitter
(require :falkjet.treesitter)

;; Fennel
(on-ft :fennel (set vim.bo.lisp true))
(tset vim.g :g:conjure#client#fennel#aniseed#aniseed_module_prefix :aniseed)

;; Guile Conjure 
(tset vim.g :conjure#client#guile#socket#pipename
      (.. (vim.fn.getcwd) "/.guile-repl.socket"))

;; Lisp Structural editing
(local sexp (require :treesitter-sexp))
(sexp.setup
  {:enabled true
   :set_cursor false})
(vim.keymap.set [:n :i] "<M-S-l>" "<cmd>TSSexp slurp_right<cr>")
(vim.keymap.set [:n :i] "<M-S-h>" "<cmd>TSSexp slurp_left<cr>")
(vim.keymap.set [:n :i] "<M-S-j>" "<cmd>TSSexp barf_left<cr>")
(vim.keymap.set [:n :i] "<M-S-k>" "<cmd>TSSexp barf_right<cr>")

;; Clojure
(on-ft :clojure (set vim.bo.lisp true))

;; TeX
(set vim.g.vimtex_mappings_enabled 0)
(set vim.g.vimtex_view_method :zathura)
(set vim.g.vimtex_quickfix_mode 1)
(set vim.g.vimtex_syntax_conceal
     {:accents 1
      :cites 1
      :fancy 1
      :greek 1
      :ligatures 1
      :math_bounds 0
      :delimiters 1
      :math_fracs 1
      :math_super_sub 1
      :math_symbols 1
      :sections 0
      :spacing 1
      :styles 1})

;; C
(set vim.g.compiler_gcc_ignore_unmatched_lines true)
(set vim.g.c_syntax_for_h true)

;; Zig
(set vim.g.zig_fmt_autosave 0) ; zls does this

;; C3
(vim.filetype.add
 {:extension {:c3 "c3"
              :c3i "c3"
              :c3t "c3"}})

;; Golang
(set vim.g.go_doc_keywordprg_enabled 0)
(set vim.g.go_def_mapping_enabled 0)
(set vim.g.go_fmt_autosave 0)

;; Obsidian markdown notes
(let [obsidian (require :obsidian)]
  (obsidian.setup
    {:workspaces [{:name "Obsidian Vault"
                   :path "~/Documents/Obsidian Vault"}]})
  (nmap "<leader>oo" "<cmd>ObsidianOpen<cr>" "[O]pen [O]bsidian")
  (nmap "<leader>os" "<cmd>ObsidianOpen<cr>" "[O]bsidian [S]earch")
  (nmap "<leader>ol" "<cmd>ObsidianOpen<cr>" "[O]bsidian [L]inks"))

;; Big question notation
(require :falkjet.bqn)

;; Fix html indent
(require :falkjet.html-indent)

;; Help (file opened by the help command)
(on-ft :help (vim.keymap.set :n :q "<cmd>q<cr>" {:buffer true}))

;; Templ (go files with html templates)
;; This would be 10 times longer to implement in fennel
(vim.cmd "autocmd BufWritePost *.templ silent! !templ generate %")
