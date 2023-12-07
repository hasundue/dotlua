{
  description = "hasundue's Neovim configuration";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    neovim-plugins.url = "./plugins";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    neovim-nightly,
    neovim-plugins,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ neovim-nightly.overlays.default ];
      }; in {
        # devShells.default = import ./nix/shell.nix { inherit pkgs; };
      }
    ) //
    {
      inherit neovim-plugins;
    };
}
