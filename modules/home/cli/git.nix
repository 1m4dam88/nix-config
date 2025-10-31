{ lib, config, pkgs, ... }:
{
  programs.git = {
    settings = {
      user.name = "1m4dam88";
      user.email = "171095855+1m4dam88@users.noreply.github.com";
      init.defaultBranch = "master";
    };
    enable = true;
  };

  home.packages = [ pkgs.gh ];
}
