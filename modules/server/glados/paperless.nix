
{ config, pkgs, ... }:
{
  services.paperless = {
    enable = true;
    user = config.homelab.user;
    dataDir = "${config.homelab.appdataDir}/paperless";
    mediaDir = "${config.homelab.mediaDir}/paperless/media";
    environmentFile = "./paperless-env";
  };
}

