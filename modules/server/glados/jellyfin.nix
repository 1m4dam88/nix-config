{ config, pkgs, lib, ... }:
{
  services = {
    jellyfin = {
      enable = true;
      configDir = "/mnt/user/appdata/jellyfin/config";
      logDir = "/mnt/user/appdata/jellyfin/config/log";
      cacheDir = "/mnt/user/appdata/jellyfin/config/cache";
      dataDir = "/mnt/user/appdata/jellyfin";
      user = "share";
      group = "share";
    };
  };

  systemd.services.jellyfin.after = [ "mnt-user.mount" ];
  systemd.services.jellyfin.requires = [ "mnt-user.mount" ];
  systemd.tmpfiles.rules = [
    "d /mnt/user/appdata/jellyfin 0775 share share -"
    "d /mnt/user/media/movies 0775 share share -"
    "d /mnt/user/media/shows 0775 share share -"
  ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ nvidia-vaapi-driver vaapiVdpau ];
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = false;
}
