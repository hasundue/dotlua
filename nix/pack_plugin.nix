{ pkgs, lib, ... }: with pkgs;

name:

input:

stdenv.mkDerivation {
  inherit name;
  src = input;

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out
    cp -r $src/* $out/
  '';
}
