{ config, pkgs, ... }:
{
  services.mpd = {
    enable = true;
    musicDirectory = "/media/NAS/media/Music/downloads/";
    dataDir = "/media/NAS/media/Music/mpd";
  };
  programs = {
    ncmpcpp = {
      enable = true;
      mpdMusicDir = "/media/NAS/media/Music/downloads/";
    };
  };
}
