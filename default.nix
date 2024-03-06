{ config, lib, pkgs, neovim-nightly, neovim-plugins, system, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = neovim-nightly.packages.${system}.neovim;

    plugins = with pkgs.vimPlugins.nvim-treesitter-parsers; [
      bash
      diff
      gitcommit
      go
      graphql
      javascript
      jsdoc
      json
      jsonc
      lua
      luadoc
      make
      markdown
      markdown_inline
      mermaid
      nix
      python
      regex
      ron
      rust
      scheme
      tsx
      typescript
      vim
      vimdoc
      yaml
      zig
    ];

    vimdiffAlias = false;
    vimAlias = false;
    viAlias = false;

    withNodeJs = false;
    withPython3 = false;
    withRuby = false;
  };

  programs.git.extraConfig.core.editor = "nvim";

  home =
  let
    nvim = lib.getExe config.programs.neovim.finalPackage;
  in
  {
    activation.neovimDppMakeState = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
      $DRY_RUN_CMD ${nvim} -l ~/.config/nvim/lua/hook/clear_dpp_state.lua
    '';
    packages = with pkgs; [
      deno
      lua-language-server
      nil
      zls
    ];
    shellAliases = rec {
      nvim = "nvim --noplugin";
      nv = "${nvim}";
    };
  };

  xdg.configFile = {
    "nvim".source = ./.;
  };

  xdg.dataFile = lib.mapAttrs'
    (name: package: lib.nameValuePair
      ("nvim/plugins/" + name)
      { source = package; }
    )
    neovim-plugins;
}
