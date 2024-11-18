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
    nixpkgs.lib.genAttrs [ "x86_64-linux" ]
      (system:
        let
          inputs' = {
            inherit self;
            lib = nixpkgs.lib // { inherit incl; };
            pkgs = import nixpkgs { inherit system; };
            srcs = { inherit (inputs) incline-nvim; };
          };
        in
        {
          neovim = import ./nix/neovim.nix inputs';
        } //
        (import ./nix/modules.nix inputs')
      ) //
    (import ./nix/dogfood.nix (inputs // { neovim-flake = self; }));
}
