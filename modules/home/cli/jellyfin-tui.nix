{ config, pkgs, ... }:
{
  home.packages = [ pkgs.jellyfin-tui ];
}
