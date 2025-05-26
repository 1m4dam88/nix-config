{ config, pkgs, lib, ... }:
{
  options.homelab = {
    rootDir = lib.mkOption {
      type = lib.types.str;
      default = "/mnt/user";
      description = "Root directory for homelab services";
    };

    appdataDir = lib.mkOption {
      type = lib.types.str;
      default = "${config.homelab.rootDir}/appdata";
      description = "Directory for application data";
    };

    mediaDir = lib.mkOption {
      type = lib.types.str;
      default = "${config.homelab.rootDir}/media";
      description = "Directory for media files";
    };

    user = lib.mkOption {
      type = lib.types.str;
      default = "share";
      description = "User for running services";
    };

    group = lib.mkOption {
      type = lib.types.str;
      default = "share";
      description = "Group for running services";
    };

    domain = lib.mkOption {
      type = lib.types.str;
      default = "tjd.lol";
      description = "Base domain for services";
    };
  };

  imports = [
    ./caddy.nix
    ./homepage.nix
    ./users.nix
  ];
}
