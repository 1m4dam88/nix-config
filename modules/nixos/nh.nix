{ config, pkgs, ... }:
{
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep-since 7d --keep 3";
    };
    flake = "/home/ye/nix-config";
  };
}
