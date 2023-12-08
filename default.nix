{ lib, pkgs, neovim-plugins, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    withNodeJs = false;
    withPython3 = false;
    withRuby = false;

    # vimdiffAlias = true;
    # vimAlias = true;
    # viAlias = true;

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
  };

  programs.git.extraConfig.core.editor = "nvim";

  home = {
    activation.neovim = 
    lib.hm.dag.entryAfter [ "linkGeneration" ] ''
      #!/bin/bash
      DPP_BASE=~/.cache/dpp

      if [ ! -d $DPP_BASE ]; then
        $DRY_RUN_CMD mkdir -p $DPP_BASE
      fi

      $DRY_RUN_CMD ${lib.getExe pkgs.neovim} --headless -u ~/.local/share/nvim/make_state.vim
    '';
    packages = with pkgs; [
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
    (name: value: lib.nameValuePair
      ("nvim/plugins/" + name)
      { source = value; })
    (lib.filterAttrs
      (name: value: name != "nixpkgs" && name != "_type" && name != "self" )
      neovim-plugins) //
    {
      "nvim/make_state.vim".source = ./make_state.vim;
    };
}
