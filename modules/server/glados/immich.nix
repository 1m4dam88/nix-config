{ config, pkgs, ... }:
{
  services.immich = {
    enable = true;
    user = config.homelab.user;
    group = config.homelab.group;
    mediaLocation = "${config.homelab.mediaDir}/immich2/photos";
    accelerationDevices = null;
  };
  users.userse.immich.extraGroups = [
    "video"
    "render"
  ];
}
