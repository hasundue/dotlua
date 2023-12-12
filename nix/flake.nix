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
    "plugins/dpp.vim" = { url = "github:Shougo/dpp.vim"; flake = false; };
    "plugins/dpp-ext-lazy" = { url = "github:Shougo/dpp-ext-lazy"; flake = false; };
    "plugins/kanagawa.nvim" = { url = "github:rebelot/kanagawa.nvim"; flake = false; };
    "plugins/denops.vim" = { url = "github:vim-denops/denops.vim"; flake = false; };
    "plugins/copilot.vim" = { url = "github:github/copilot.vim"; flake = false; };
    "plugins/gitsigns.nvim" = { url = "github:lewis6991/gitsigns.nvim"; flake = false; };
    "plugins/nvim-treesitter" = { url = "github:nvim-treesitter/nvim-treesitter"; flake = false; };
    "plugins/nvim-lspconfig" = { url = "github:neovim/nvim-lspconfig"; flake = false; };
    "plugins/lsp_signature.nvim" = { url = "github:ray-x/lsp_signature.nvim"; flake = false; };
    "plugins/vim-sandwich" = { url = "github:machakann/vim-sandwich"; flake = false; };
    "plugins/ddc.vim" = { url = "github:Shougo/ddc.vim"; flake = false; };
    "plugins/ddc-file" = { url = "github:LumaKernel/ddc-file"; flake = false; };
    "plugins/ddc-cmdline" = { url = "github:Shougo/ddc-cmdline"; flake = false; };
    "plugins/ddc-cmdline-history" = { url = "github:Shougo/ddc-cmdline-history"; flake = false; };
    "plugins/ddc-source-lsp" = { url = "github:Shougo/ddc-source-lsp"; flake = false; };
    "plugins/ddc-ui-pum" = { url = "github:Shougo/ddc-ui-pum"; flake = false; };
    "plugins/ddc-fuzzy" = { url = "github:tani/ddc-fuzzy"; flake = false; };
    "plugins/ddu.vim" = { url = "github:Shougo/ddu.vim"; flake = false; };
    "plugins/ddu-commands.vim" = { url = "github:Shougo/ddu-commands.vim"; flake = false; };
    "plugins/ddu-filter-zf" = { url = "github:hasundue/ddu-filter-zf"; flake = false; };
    "plugins/ddu-source-mr" = { url = "github:kuuote/ddu-source-mr"; flake = false; };
    "plugins/ddu-source-file_external" = { url = "github:matsui54/ddu-source-file_external"; flake = false; };
    "plugins/ddu-source-help" = { url = "github:matsui54/ddu-source-help"; flake = false; };
    "plugins/ddu-ui-ff" = { url = "github:Shougo/ddu-ui-ff"; flake = false; };
    "plugins/ddu-kind-file" = { url = "github:Shougo/ddu-kind-file"; flake = false; };
    "plugins/ddu-source-rg" = { url = "github:shun/ddu-source-rg"; flake = false; };
    "plugins/ddu-source-buffer" = { url = "github:shun/ddu-source-buffer"; flake = false; };
    "plugins/ddu-source-lsp" = { url = "github:uga-rosa/ddu-source-lsp"; flake = false; };
    "plugins/vim-floaterm" = { url = "github:voldikss/vim-floaterm"; flake = false; };
    "plugins/markdown-preview.nvim" = { url = "github:iamcco/markdown-preview.nvim"; flake = false; };
    "plugins/mr.vim" = { url = "github:lambdalisue/mr.vim"; flake = false; };
    "plugins/pum.vim" = { url = "github:Shougo/pum.vim"; flake = false; };
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
      }; 
      lib = pkgs.lib;
    in {
      packages = with lib; mapAttrs
          (name: input: import ./pack_plugin.nix { inherit pkgs lib; } name input)
          (mapAttrs'
            (name: input: nameValuePair (removePrefix "plugins/" name) input)
            (filterAttrs (name: value: hasPrefix "plugins/" name) inputs)
          );
    }
  );
}
