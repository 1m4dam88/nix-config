{ lib, config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "1m4dam88";
    userEmail = "171095855+1m4dam88@users.noreply.github.com";

    extraConfig = {
      init.defaultBranch = "master";
      credential.helper = "store";
      url."https://github.com/".insteadOf = "git@github.com:"; # Prefer HTTPS
    };
  };

  home.packages = [ pkgs.gh ];
}
