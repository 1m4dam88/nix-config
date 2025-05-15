{ config, pkgs, lib, ... }:
{
  services = {
    deluge = {
      enable = true;
      web.enable = true;
      declarative = true;
      dataDir = "/mnt/user/appdata/deluge";
      authFile = "${config.sops.secrets.deluge.path}";
      group = "share";
      user = "share";
      config = {
        download_location = "/mnt/user/media/torrents";
      };
    };
  };
}
