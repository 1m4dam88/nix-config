{ config, pkgs, ... }:
{
  services.immich = {
    enable = true;
    mediaLocation = "${config.homelab.mediaDir}/immich-new/photos";
    accelerationDevices = null;
  };
}
