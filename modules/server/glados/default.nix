{ config, pkgs, lib }:
let
  rootDir = "/mnt/user";
  appdataDir = "/mnt/user/appdata";
  mediaDir = "/mnt/user/media";
in 
{
  imports = [
    ./mergerfs.nix
  ];
}
