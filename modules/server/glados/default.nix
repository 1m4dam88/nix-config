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

    storageDir = lib.mkOption {
      type = lib.types.str;
      default = "${config.homelab.rootDir}/storage";
      description = "Directory for general storage";
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
    ./arr.nix
    ./deluge.nix
    ./caddy.nix
    ./immich.nix
    ./homepage.nix
    ./jellyfin.nix
    ./jellyseerr.nix
    ./mergerfs.nix
    ./share.nix
    ./paperless.nix
    ./searx.nix
    ./users.nix
    ./vaultwarden.nix
  ];
}
