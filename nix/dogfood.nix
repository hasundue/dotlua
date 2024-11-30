{ nixpkgs
, flake-utils
, neovim-flake
, ...
}:
flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
let
  pkgs = nixpkgs.legacyPackages.${system};
  lib = nixpkgs.lib;
in
rec {
  packages = with neovim-flake.${system}; lib.mapAttrs
    (name: modules: mkNeovim { inherit modules; })
    {
      default = [ core lua nix ];
      deno = [ core deno ];
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
