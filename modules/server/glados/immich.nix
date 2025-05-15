{ config, pkgs, lib, ... }:
{
  services = {
    immich = {
      enable = true;
      mediaLocation = "/mnt/user/media/immich-new/photos";
      accelerationDevices = null;
    };
  };
}
