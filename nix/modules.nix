{ pkgs, self, ... } @ inputs:

let
  plugins = import ./plugins.nix inputs;
  parsers = plugins.nvim-treesitter-parsers;
in
{
  core = {
    configs = [ (self + /lua/core) ];

    packages = with pkgs; [
      fd
      git
      lazygit
      ripgrep
    ];

    plugins = with plugins; [
      # colorscheme
      kanagawa-nvim

      # libraries
      nui-nvim
      nvim-notify
      nvim-web-devicons
      plenary-nvim

      # ui
      incline-nvim
      lualine-nvim
      oil-nvim
      noice-nvim
      no-neck-pain-nvim
      telescope-nvim
      vim-floaterm

      # cmp
      cmp-buffer
      cmp-cmdline
      cmp-nvim-lsp
      cmp-path
      cmp-snippy
      nvim-cmp
      nvim-snippy

      # lsp
      nvim-lspconfig

      # treesitter
      nvim-treesitter

      # utils
      vim-sandwich
    ];
  };

  clipboard.configs = [ (self + /lua/clipboard.lua) ];

  copilot = {
    configs = [ (self + /lua/feat/copilot.lua) ];
    packages = with pkgs; [
      nodejs
    ];
    plugins = with plugins; [
      copilot-lua
    ];
  };

  deno = {
    configs = [ (self + /lua/deno.lua) ];
    packages = with pkgs; [ deno ];
    plugins = with parsers; [
      javascript
      jsdoc
      json
      jsonc
      tsx
      typescript
    ];
  };

  lua = {
    configs = [ (self + /lua/lua.lua) ];
    packages = with pkgs; [
      lua-language-server
    ];
    plugins = with parsers; [
      luadoc
    ];
  };

  nix = {
    configs = [ (self + /lua/nix.lua) ];
    packages = with pkgs; [
      nil
      nixpkgs-fmt
    ];
    plugins = with parsers; [
      nix
    ];
  };

  rust = {
    configs = [ (self + /lua/rust.lua) ];
    packages = with pkgs; [
      rustup
      rust-analyzer
      rustfmt
    ];
    plugins = with parsers; [
      rust
      toml
    ];
  };
}
