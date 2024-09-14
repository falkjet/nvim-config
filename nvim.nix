{ pkgs }:
let rcfile = ./init.lua;
in pkgs.neovim.override {
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
          src = builtins.fetchGit {
            url = "https://github.com/vim-scripts/loremipsum";
            rev = "39354ae1c86c89bf36a4af7c6d4b9ca0c0a9eedf";
          };
        })
        (pkgs.vimUtils.buildVimPlugin {
          pname = "git-worktree-nvim";
          version = "e9baf2d2f9908509459daf7b760fc9d4b4d84588";
          src = builtins.fetchGit {
            url = "https://github.com/ThePrimeagen/git-worktree.nvim";
            rev = "e9baf2d2f9908509459daf7b760fc9d4b4d84588";
          };
        })

        (pkgs.vimUtils.buildVimPlugin {
          pname = "vim-suda";
          version = "b97fab52f9cdeabe2bbb5eb98d82356899f30829";
          src = builtins.fetchGit {
            url = "https://github.com/lambdalisue/vim-suda";
            rev = "b97fab52f9cdeabe2bbb5eb98d82356899f30829";
          };
        })

        (pkgs.vimUtils.buildVimPlugin {
          pname = "tree-sitter-bqn";
          version = "8c62b746924398304c8fa1aa18393c3124d1e50d";
          src = pkgs.runCommand "tree-sitter-bqn-src" { } ''
            mkdir --parents $out/queries
            cp -r ${
              pkgs.fetchFromGitHub {
                owner = "shnarazk";
                repo = "tree-sitter-bqn";
                rev = "8c62b746924398304c8fa1aa18393c3124d1e50d";
                sha256 = "sha256-jK0zn7DWzy2yfYOX1ZBoGOC7QBrcp4PHWnaOKaDL9ws=";
              }
            }/queries $out/queries/bqn
          '';
        })

        (pkgs.vimUtils.buildVimPlugin {
          pname = "tree-sitter-nu";
          version = "0bb9a602d9bc94b66fab96ce51d46a5a227ab76c";
          src = pkgs.fetchFromGitHub {
            owner = "nushell";
            repo = "tree-sitter-nu";
            rev = "0bb9a602d9bc94b66fab96ce51d46a5a227ab76c";
            sha256 = "sha256-A5GiOpITOv3H0wytCv6t43buQ8IzxEXrk3gTlOrO0K0=";
          };
        })

        (nvim-treesitter.withPlugins (_:
          nvim-treesitter.allGrammars ++ [
            (pkgs.tree-sitter.buildGrammar {
              language = "bqn";
              version = "8c62b746924398304c8fa1aa18393c3124d1e50d";
              src = pkgs.fetchFromGitHub {
                owner = "shnarazk";
                repo = "tree-sitter-bqn";
                rev = "8c62b746924398304c8fa1aa18393c3124d1e50d";
                sha256 = "sha256-jK0zn7DWzy2yfYOX1ZBoGOC7QBrcp4PHWnaOKaDL9ws=";
              };
            })
            (pkgs.tree-sitter.buildGrammar {
              language = "nu";
              version = "0bb9a602d9bc94b66fab96ce51d46a5a227ab76c";
              src = pkgs.fetchFromGitHub {
                owner = "nushell";
                repo = "tree-sitter-nu";
                rev = "0bb9a602d9bc94b66fab96ce51d46a5a227ab76c";
                sha256 = "sha256-A5GiOpITOv3H0wytCv6t43buQ8IzxEXrk3gTlOrO0K0=";
              };
            })
          ]))

        vim-sexp
        vim-repeat
        vim-fugitive
        vim-rhubarb
        vim-surround
        vim-sleuth

        ultimate-autopair-nvim

        comment-nvim
        obsidian-nvim

        harpoon
        tabular
        gitsigns-nvim
        git-worktree-nvim

        nvim-web-devicons
        oil-nvim

        nvim-lspconfig
        neodev-nvim
        lsp-format-nvim
        trouble-nvim

        nvim-dap
        nvim-dap-ui

        nvim-cmp
        cmp-nvim-lsp
        luasnip
        friendly-snippets

        vim-tmux-navigator
        which-key-nvim
        neoconf-nvim

        conjure
        cmp-conjure

        catppuccin-nvim
        onedark-nvim
        lualine-nvim

        fidget-nvim
        telescope-nvim
        telescope-ui-select-nvim

        nvim-treesitter-textobjects
        treesj

        neodev-nvim
        neoconf-nvim

        fennel-vim
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
