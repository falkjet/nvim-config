{ pkgs }:
let
  rcfile = ./init.lua;
  plugin-parser = import ./plugins-parser.nix { inherit pkgs; };
  plugin-overrides = with pkgs.vimPlugins; {
    nvim-treesitter = (nvim-treesitter.withPlugins (_:
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
      ]));
  };
in pkgs.neovim.override {
  configure = {
    customRC = ''
      luafile ${rcfile}
    '';
    packages.falkjet = {
      start =
        builtins.attrValues ((plugin-parser ./plugins.txt) // plugin-overrides);
    };
  };
}
