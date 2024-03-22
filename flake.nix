{
  description = "A neovim heavily configured neovim";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };
  outputs = { self, nixpkgs }:
    let pkgs = import nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
    in
    {
      packages.x86_64-linux.neovim = import ./nvim.nix { inherit pkgs; };
      packages.x86_64-linux.default = self.packages.x86_64-linux.neovim;
    };
}
