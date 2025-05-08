{ config, pkgs, lib, ... }:
{
  services = {
    deluge = {
      enable = true;
      web.enable = true;
      declarative = true;
      dataDir = "${appdataDir}/deluge";
      config = {
        download_location = "${mediaDir}/torrents";
      };
    };
  };
}
