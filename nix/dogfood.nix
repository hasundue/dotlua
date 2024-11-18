{ nixpkgs
, flake-utils
, neovim-flake
, ...
}:
flake-utils.lib.eachSystem [ "x86_64-linux" ] (system: {
  apps = {
    default = {
      type = "app";
      program = nixpkgs.lib.getExe (with neovim-flake.${system}; neovim {
        modules = [ core lua nix ];
      });
    };
  };
})
