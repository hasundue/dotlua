{ nixpkgs
, flake-utils
, nvim-flake
, ...
}:
flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
let
  pkgs = nixpkgs.legacyPackages.${system};
  lib = nixpkgs.lib;
  nvim = nvim-flake.${system};
in
rec {
  packages = with nvim.modules;
    {
      full = nvim { modules = all; };
    } //
    lib.mapAttrs
      (name: extra: nvim {
        modules = [ core clipboard copilot ] ++ extra;
      })
      {
        default = [ lua nix ];
        deno = [ deno ];
      };

  devShells = lib.mapAttrs
    (name: package: pkgs.mkShell {
      inherit name;
      packages = [ package ];
      shellHook = ''
        alias nv=nvim
      '';
    })
    packages;
})
