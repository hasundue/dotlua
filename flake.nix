{
  description = "hasundue's Neovim configuration";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    plugins.url = "./dist/plugins";
  };

  outputs = inputs: {
    neovim-plugins = inputs;
  };
}
