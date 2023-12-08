{
  description = "hasundue's Neovim configuration";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    /* PLUGINS START */
    /* PLUGINS END */
  };

  outputs = {
    nixpkgs,
    flake-utils,
    neovim-nightly,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ neovim-nightly.overlays.default ];
      }; in {
        # devShells.default = import ./nix/shell.nix { inherit pkgs; };
      }
    ) //
    {
      plugins = with nixpkgs.lib; mapAttrs'
        (name: value: nameValuePair
          (removePrefix "plugin:" name)
          value
        )
        (lib.filterAttrs
          (name: value: hasPrefix "plugin:" name)
          inputs
        );
    };
}
