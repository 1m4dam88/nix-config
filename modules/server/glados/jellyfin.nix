{ config, pkgs, lib, ... }:
{
  services.jellyfin = {
    enable = true;
    configDir = "${config.homelab.appdataDir}/jellyfin/config";
    logDir = "${config.homelab.appdataDir}/jellyfin/config/log";
    cacheDir = "${config.homelab.appdataDir}/jellyfin/config/cache";
    dataDir = "${config.homelab.appdataDir}/jellyfin";
    user = config.homelab.user;
    group = config.homelab.group;
  };

  systemd.services.jellyfin = {
    after = [ "mnt-user.mount" ];
    requires = [ "mnt-user.mount" ];
  };

  systemd.tmpfiles.rules = [
    "d ${config.homelab.appdataDir}/jellyfin 0775 ${config.homelab.user} ${config.homelab.group} -"
    "d ${config.homelab.mediaDir}/movies 0775 ${config.homelab.user} ${config.homelab.group} -"
    "d ${config.homelab.mediaDir}/shows 0775 ${config.homelab.user} ${config.homelab.group} -"
  ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ nvidia-vaapi-driver vaapiVdpau ];
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = false;
}
