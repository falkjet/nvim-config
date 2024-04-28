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
        (pkgs.vimUtils.buildVimPlugin {
          pname = "git-worktree-nvim";
          version = "e9baf2d2f9908509459daf7b760fc9d4b4d84588";
          src = builtins.fetchGit{
            url = "https://github.com/ThePrimeagen/git-worktree.nvim";
            rev = "e9baf2d2f9908509459daf7b760fc9d4b4d84588";
          };
        })


        vim-fugitive
        vim-rhubarb
        vim-surround
        vim-sleuth

        comment-nvim

        nvim-autopairs
        harpoon
        tabular
        gitsigns-nvim
        git-worktree-nvim

        nvim-web-devicons
        oil-nvim

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
