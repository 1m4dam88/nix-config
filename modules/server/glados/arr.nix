{ config, pkgs, ... }:
{
  services = {
    sonarr = {
      enable = true;
      dataDir = "/mnt/user/appdata/sonarr";
      user = "share";
      group = "share";
    };
    radarr = {
      enable = true;
      dataDir = "/mnt/user/appdata/radarr";
      user = "share";
      group = "share";
    };
    prowlarr = {
      enable = true;
    };
    flaresolverr = {
      enable = true;
    };
  };
}
