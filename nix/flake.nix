{
  description = "hasundue's Neovim plugins";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    /* PLUGINS START */
    "plugins/dpp.vim" = { url = "github:Shougo/dpp.vim"; flake = false; };
    "plugins/dpp-ext-lazy" = { url = "github:Shougo/dpp-ext-lazy"; flake = false; };
    "plugins/kanagawa.nvim" = { url = "github:rebelot/kanagawa.nvim"; flake = false; };
    "plugins/lualine.nvim" = { url = "github:nvim-lualine/lualine.nvim"; flake = false; };
    "plugins/nvim-web-devicons" = { url = "github:nvim-tree/nvim-web-devicons"; flake = false; };
    "plugins/noice.nvim" = { url = "github:folke/noice.nvim"; flake = false; };
    "plugins/incline.nvim" = { url = "github:b0o/incline.nvim"; flake = false; };
    "plugins/nvim-lspconfig" = { url = "github:neovim/nvim-lspconfig"; flake = false; };
    "plugins/nvim-treesitter" = { url = "github:nvim-treesitter/nvim-treesitter"; flake = false; };
    "plugins/gitsigns.nvim" = { url = "github:lewis6991/gitsigns.nvim"; flake = false; };
    "plugins/no-neck-pain.nvim" = { url = "github:shortcuts/no-neck-pain.nvim"; flake = false; };
    "plugins/ccc.nvim" = { url = "github:uga-rosa/ccc.nvim"; flake = false; };
    "plugins/nvim-cmp" = { url = "github:hrsh7th/nvim-cmp"; flake = false; };
    "plugins/copilot.lua" = { url = "github:zbirenbaum/copilot.lua"; flake = false; };
    "plugins/cmp-buffer" = { url = "github:hrsh7th/cmp-buffer"; flake = false; };
    "plugins/cmp-cmdline" = { url = "github:hrsh7th/cmp-cmdline"; flake = false; };
    "plugins/cmp-emoji" = { url = "github:hrsh7th/cmp-emoji"; flake = false; };
    "plugins/cmp-nvim-lsp" = { url = "github:hrsh7th/cmp-nvim-lsp"; flake = false; };
    "plugins/cmp-path" = { url = "github:hrsh7th/cmp-path"; flake = false; };
    "plugins/cmp-snippy" = { url = "github:dcampos/cmp-snippy"; flake = false; };
    "plugins/nvim-snippy" = { url = "github:dcampos/nvim-snippy"; flake = false; };
    "plugins/cmp-skkeleton" = { url = "github:rinx/cmp-skkeleton"; flake = false; };
    "plugins/skkeleton" = { url = "github:vim-skk/skkeleton"; flake = false; };
    "plugins/vim-sandwich" = { url = "github:machakann/vim-sandwich"; flake = false; };
    "plugins/telescope.nvim" = { url = "github:nvim-telescope/telescope.nvim"; flake = false; };
    "plugins/oil.nvim" = { url = "github:stevearc/oil.nvim"; flake = false; };
    "plugins/vim-floaterm" = { url = "github:voldikss/vim-floaterm"; flake = false; };
    "plugins/markdown-preview.nvim" = { url = "github:iamcco/markdown-preview.nvim"; flake = false; };
    "plugins/peek.nvim" = { url = "github:toppair/peek.nvim"; flake = false; };
    "plugins/nui.nvim" = { url = "github:MunifTanjim/nui.nvim"; flake = false; };
    "plugins/plenary.nvim" = { url = "github:nvim-lua/plenary.nvim"; flake = false; };
    "plugins/nvim-notify" = { url = "github:rcarriga/nvim-notify"; flake = false; };
    "plugins/denops.vim" = { url = "github:vim-denops/denops.vim"; flake = false; };
    /* PLUGINS END */
  };

  outputs = { nixpkgs, flake-utils, ... } @ inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
        lib = pkgs.lib;
      in
      {
        packages = with lib; mapAttrs
          (name: input: import ./pack_plugin.nix { inherit pkgs lib; } name input)
          (mapAttrs'
            (name: input: nameValuePair (removePrefix "plugins/" name) input)
            (filterAttrs (name: value: hasPrefix "plugins/" name) inputs)
          );
      }
    );
}
