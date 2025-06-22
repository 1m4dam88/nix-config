{ config, pkgs, lib, ... }:
{
  services = {
    qbittorrent = {
      enable = true;
      port = 8090;
      user = "share";
      group = "share";
    }
  }
}
