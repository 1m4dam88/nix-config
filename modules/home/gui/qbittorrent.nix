{ pkgs, config, ... }:
{
    home.packages = with pkgs; [ qbittorrent ];
}
