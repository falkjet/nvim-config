{
  description = "A neovim heavily configured neovim";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    neovim-nightly-overlay = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/neovim-nightly-overlay";
    };
  };
  outputs = { self, nixpkgs, neovim-nightly-overlay }:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
        overlays = [ neovim-nightly-overlay.overlay ];
      };
    in {
      packages.x86_64-linux.neovim = import ./nvim.nix { inherit pkgs; };
      packages.x86_64-linux.default = self.packages.x86_64-linux.neovim;
    };
}
