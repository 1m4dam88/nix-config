{ lib, config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "1m4dam88";
    userEmail = "imadam1@proton.me";

    extraConfig = {
      init.defaultBranch = "master";
    };
  };

  home.packages = [ pkgs.gh ];
}
