{
  description = "A neovim heavily configured neovim";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          system = system;
          config.allowUnfree = true;
        };
      in {
        packages = rec {
          neovim = import ./nvim.nix { inherit pkgs; };
          default = neovim;
        };
      });
}
