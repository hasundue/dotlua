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
    "plugin:dpp.vim" = { url = "github:Shougo/dpp.vim"; flake = false; };
    "plugin:dpp-ext-lazy" = { url = "github:Shougo/dpp-ext-lazy"; flake = false; };
    "plugin:kanagawa.nvim" = { url = "github:rebelot/kanagawa.nvim"; flake = false; };
    "plugin:denops.vim" = { url = "github:vim-denops/denops.vim"; flake = false; };
    "plugin:gitsigns.nvim" = { url = "github:lewis6991/gitsigns.nvim"; flake = false; };
    "plugin:nvim-treesitter" = { url = "github:nvim-treesitter/nvim-treesitter"; flake = false; };
    "plugin:nvim-lspconfig" = { url = "github:neovim/nvim-lspconfig"; flake = false; };
    "plugin:lsp_signature.nvim" = { url = "github:ray-x/lsp_signature.nvim"; flake = false; };
    "plugin:vim-sandwich" = { url = "github:machakann/vim-sandwich"; flake = false; };
    "plugin:copilot.vim" = { url = "github:github/copilot.vim"; flake = false; };
    "plugin:ddc.vim" = { url = "github:Shougo/ddc.vim"; flake = false; };
    "plugin:ddc-file" = { url = "github:LumaKernel/ddc-file"; flake = false; };
    "plugin:ddc-cmdline" = { url = "github:Shougo/ddc-cmdline"; flake = false; };
    "plugin:ddc-cmdline-history" = { url = "github:Shougo/ddc-cmdline-history"; flake = false; };
    "plugin:ddc-source-lsp" = { url = "github:Shougo/ddc-source-lsp"; flake = false; };
    "plugin:ddc-ui-pum" = { url = "github:Shougo/ddc-ui-pum"; flake = false; };
    "plugin:pum.vim" = { url = "github:Shougo/pum.vim"; flake = false; };
    "plugin:ddc-fuzzy" = { url = "github:tani/ddc-fuzzy"; flake = false; };
    "plugin:ddu.vim" = { url = "github:Shougo/ddu.vim"; flake = false; };
    "plugin:ddu-commands.vim" = { url = "github:Shougo/ddu-commands.vim"; flake = false; };
    "plugin:ddu-filter-zf" = { url = "github:hasundue/ddu-filter-zf"; flake = false; };
    "plugin:ddu-source-mr" = { url = "github:kuuote/ddu-source-mr"; flake = false; };
    "plugin:ddu-source-file_external" = { url = "github:matsui54/ddu-source-file_external"; flake = false; };
    "plugin:ddu-source-help" = { url = "github:matsui54/ddu-source-help"; flake = false; };
    "plugin:ddu-ui-ff" = { url = "github:Shougo/ddu-ui-ff"; flake = false; };
    "plugin:ddu-kind-file" = { url = "github:Shougo/ddu-kind-file"; flake = false; };
    "plugin:ddu-source-rg" = { url = "github:shun/ddu-source-rg"; flake = false; };
    "plugin:ddu-source-buffer" = { url = "github:shun/ddu-source-buffer"; flake = false; };
    "plugin:ddu-source-lsp" = { url = "github:uga-rosa/ddu-source-lsp"; flake = false; };
    "plugin:vim-floaterm" = { url = "github:voldikss/vim-floaterm"; flake = false; };
    "plugin:mr.vim" = { url = "github:lambdalisue/mr.vim"; flake = false; };
    "plugin:markdown-preview.nvim" = { url = "github:iamcco/markdown-preview.nvim"; flake = false; };
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
        (filterAttrs
          (name: value: hasPrefix "plugin:" name)
          inputs
        );
    };
}
