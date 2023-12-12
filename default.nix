{ lib, pkgs, neovim-plugins, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

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
  /* let
    nvim = lib.getExe config.programs.neovim.finalPackage;
  in */
  {
    /* activation.neovimDppMakeState = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
      #!/bin/bash
      STATE_DIR=~/.cache/dpp/nvim
      if [ -d $STATE_DIR ]; then
        $DRY_RUN_CMD rm -rf $STATE_DIR
      fi
      $DRY_RUN_CMD mkdir -p $STATE_DIR

      # TODO: Make this work
      # $DRY_RUN_CMD ${nvim} --headless -u ~/.local/share/nvim/make_state.vim
    ''; */
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
    "nvim/init.lua".source = ./init.lua;
    "nvim/lua".source = ./lua;
    "nvim/rc".source = ./rc;
  };

  xdg.dataFile = lib.mapAttrs'
    (name: package: lib.nameValuePair
      ("nvim/plugins/" + name)
      { source = package; })
    neovim-plugins;
}
