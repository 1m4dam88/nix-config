{ config, pkgs, lib, ... }:
{
  services = {
    qbittorrent = {
      enable = true;
      port = 8090;
      user = config.homelab.user;
      group = config.homelab.group;
    }
  }
}
