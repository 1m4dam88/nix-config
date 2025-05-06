{ lib, config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "imadam";
    userEmail = "imadam1@proton.me";

    extraConfig = {
      init.defaultBranch = "master";
    };
  };

  home.packages = [ pkgs.gh ];
}
