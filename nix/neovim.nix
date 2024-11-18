{ pkgs, lib, self, ... }:

let
  normalizeModule =
    { configs ? [ ]
    , packages ? [ ]
    , plugins ? [ ]
    } @ attrs: attrs;

  formatRequireLine = path:
    let name = with lib; removePrefix (self + "/lua/") (removeSuffix ".lua" path);
    in ''require("${name}")'';

  wrapNeovim = { configs, packages, plugins }:
    let
      neovimConfig = pkgs.neovimUtils.makeNeovimConfig { };
      configDir = lib.incl self (configs ++ [ (self + "/lua/lib") ]);
      requireLines = lib.concatLines (map formatRequireLine configs);
    in
    with pkgs; wrapNeovimUnstable neovim-unwrapped (neovimConfig // {
      inherit plugins;

      luaRcContent = ''
        vim.opt.runtimepath:append("${configDir}");
        ${requireLines}
      '';

      wrapperArgs = neovimConfig.wrapperArgs
        ++ [ "--suffix" "PATH" ":" (lib.makeBinPath packages) ];

      wrapRc = true;

      withNodeJs = false;
      withPython3 = false;
      withRuby = false;
    });
in
{ modules ? [ ] }: wrapNeovim (with lib; foldAttrs concat [ ] (map normalizeModule modules))
