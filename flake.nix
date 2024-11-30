{
  description = "My Neovim flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";
    incl.url = "github:divnix/incl";

    incline-nvim = {
      url = "github:b0o/incline.nvim";
      flake = false;
    };
  };

  outputs = { nixpkgs, incl, self, ... } @ inputs:
    let
      forSystem = system: module: (import module) {
        inherit self;
        lib = nixpkgs.lib // { inherit incl; };
        pkgs = nixpkgs.legacyPackages.${system};
        srcs = { inherit (inputs) incline-nvim; };
      };
    in
    nixpkgs.lib.genAttrs [ "x86_64-linux" ]
      (system:
        {
          mkNeovim = forSystem system ./nix/neovim.nix;
        } //
        (forSystem system ./nix/modules.nix)
      ) //
    (import ./nix/dogfood.nix (inputs // { neovim-flake = self; }));
}
