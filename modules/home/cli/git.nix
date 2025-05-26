{ lib, config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "1m4dam88";
    userEmail = "171095855+1m4dam88@users.noreply.github.com";

    extraConfig = {
      init.defaultBranch = "master";
    };
  };

  home.packages = [ pkgs.gh ];
}
