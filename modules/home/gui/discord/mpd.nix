{ config, pkgs, ... }:
{
  home.packages = with pkgs; [ mpd-discord-rpc ];
}
