{ pkgs, lib, ... }: with pkgs;

name:

input:

stdenv.mkDerivation {
  inherit name;
  src = input;

  nativeBuildInputs = [ deno ];

  configurePhase = ":";

  buildPhase = ":";

  installPhase = ''
    mkdir -p $out
    cp -r $src/* $out/
  '';
}
