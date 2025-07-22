{ config, pkgs, ... }:
{
  services.immich = {
    enable = true;
    mediaLocation = "${config.homelab.mediaDir}/immich/photos";
    accelerationDevices = null;
  };
}
