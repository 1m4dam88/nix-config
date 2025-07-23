{ config, pkgs, ... }:
{
  services.immich = {
    enable = true;
    user = "share";
    group = "share";
    mediaLocation = "${config.homelab.mediaDir}/immich/photos";
    accelerationDevices = null;
  };
}
