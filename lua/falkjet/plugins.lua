return {
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Indent detection
  'tpope/vim-sleuth',

  -- Autopairs
  'windwp/nvim-autopairs',

  -- Harpoon
  'ThePrimeagen/harpoon',

  -- Formatting
  'stevearc/conform.nvim',

  -- Adds git related signs to the gutter, as well as utilities for managing changes
  { 'lewis6991/gitsigns.nvim', config = true },

  {
    -- Surround
    'tpope/vim-surround',
    init = function()
      vim.keymap.set('n', 'mr', '<Plug>Csurround', { desc = 'Surround [R]eplace' })
      vim.keymap.set('n', 'md', '<Plug>Dsurround', { desc = 'Surround [D]elete' })
      vim.keymap.set('v', 'ms', '<Plug>VSurround', { desc = '[S]urround' })
    end
  },
  {
    -- LSP
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },
      'williamboman/mason-lspconfig.nvim',
      'folke/neodev.nvim',
      'lukas-reineke/lsp-format.nvim',
    },
  },
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'rafamadriz/friendly-snippets',
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<m-h>",  "<cmd>TmuxNavigateLeft<cr>" },
      { "<m-j>",  "<cmd>TmuxNavigateDown<cr>" },
      { "<m-k>",  "<cmd>TmuxNavigateUp<cr>" },
      { "<m-l>",  "<cmd>TmuxNavigateRight<cr>" },
      { "<m-\\>", "<cmd>TmuxNavigatePrevious<cr>" },
    },
  },
  { 'folke/which-key.nvim',    opts = {} },
  { 'folke/neoconf.nvim' },

  {
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      local onedark = require 'onedark'
      onedark.setup {
        style = "deep"
      }
      onedark.load()
    end
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
    },
  },
  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-telescope/telescope-ui-select.nvim',
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },


  -- Languages
  'purescript-contrib/purescript-vim',
  'alaviss/nim.nvim',
  'vim-scripts/maude.vim',
  'Joe-Davidson1802/templ.vim',
  'nfnty/vim-nftables',
  'preservim/vim-markdown',
  'jlcrochet/vim-razor',
  'DingDean/wgsl.vim',
  {
    'iamcco/markdown-preview.nvim',
    init = function()
      vim.g.vim_markdown_frontmatter = 1
      vim.g.vim_markdown_toml_frontmatter = 1
      vim.g.vim_markdown_math = 1
    end
  },
  {
    'fatih/vim-go',
    init = function()
      vim.filetype.add {
        extension = {
          tmpl = 'gohtmltmpl'
        }
      }
      vim.g.go_doc_keywordprg_enabled = 0
      vim.g.go_def_mapping_enabled = 0
    end
  },


  {
    'lervag/vimtex',
    init = function()
      vim.g.tex_flavor = 'latex'
      vim.g.vimtex_view_method = 'zathura'
      vim.g.vimtex_quickfix_mode = 0
      vim.o.conceallevel = 1
      vim.g.tex_conceal = 'abmgs'
      vim.g.vimtex_compiler_engine = 'lualatex'
      vim.g.vimtex_syntax_conceal = {
        accents = 1,
        cites = 1,
        fancy = 1,
        greek = 1,
        ligatures = 1,
        math_bounds = 0,
        delimiters = 1,
        math_fracs = 1,
        math_super_sub = 1,
        math_symbols = 1,
        sections = 0,
        spacing = 1,
        styles = 1,
      }
    end,
  },
}

-- vim: ts=2 sts=2 sw=2 et
