{ config, pkgs, ... }:
{
  services.deluge = {
    enable = true;
    web.enable = true;
    declarative = true;
    dataDir = "${config.homelab.appdataDir}/deluge";
    authFile = "${config.sops.secrets.deluge.path}";
    group = config.homelab.group;
    user = config.homelab.user;
    config = {
      download_location = "${config.homelab.mediaDir}/torrents";
    };
  };
}
