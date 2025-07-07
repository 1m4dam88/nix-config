{ pkgs, ... }:
{
  home.packages = with pkgs; [ 
    jellyfin-media-player
    jellyfin-mpv-shim
  ];
}
