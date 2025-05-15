{ config, pkgs, lib, ... }:
{
  services = {
    paperless = {
      enable = true;
      user = "share";
      dataDir = "/mnt/user/appdata/paperless";
      mediaDir = "/mnt/user/media/paperless/media";
      environmentFile = "/home/ye/nix-config/modules/server/glados/paperless-env";
    };
  };
}
