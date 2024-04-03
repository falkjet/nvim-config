{ pkgs }:
let
  rcfile = ./init.lua;
in
pkgs.neovim.override {
  configure = {
    customRC = ''
      luafile ${rcfile}
    '';
    packages.falkjet = with pkgs.vimPlugins; {
      start = [
        (pkgs.vimUtils.buildVimPlugin {
          pname = "falkjet-nvim";
          version = "1.0";
          src = ./.;
        })
        (pkgs.vimUtils.buildVimPlugin {
          pname = "loremipsum";
          version = "0.2";
          src = builtins.fetchGit{
            url = "https://github.com/vim-scripts/loremipsum";
            rev = "39354ae1c86c89bf36a4af7c6d4b9ca0c0a9eedf";
          };
        })

        vim-fugitive
        vim-rhubarb
        vim-surround
        vim-sleuth

        nvim-autopairs
        harpoon
        tabular
        gitsigns-nvim

        nvim-lspconfig
        neodev-nvim
        lsp-format-nvim

        nvim-dap
        nvim-dap-ui

        nvim-cmp
        cmp-nvim-lsp
        luasnip
        friendly-snippets

        vim-tmux-navigator
        which-key-nvim
        neoconf-nvim

        onedark-nvim
        lualine-nvim

        fidget-nvim
        telescope-nvim
        telescope-ui-select-nvim

        nvim-treesitter.withAllGrammars
        nvim-treesitter-textobjects

        purescript-vim
        vim-nftables
        vim-markdown
        wgsl-vim
        markdown-preview-nvim
	vim-go
	vimtex
      ];
    };
  };
}

