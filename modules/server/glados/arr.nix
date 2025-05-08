{ config, pkgs, ... }:
{
  services = {
    sonarr = {
      enable = true;
      dataDir = "${appdataDir}/sonarr"
    };
    radarr = {
      enable = true;
      dataDir = "${appdataDir}/radarr"
    };
    prowlarr = {
      enable = true;
      dataDir = "${appdataDir}/prowlarr"
    };
  };
}
