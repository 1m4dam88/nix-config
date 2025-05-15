{ config, pkgs, lib, ... }:
let
  rootDir = "/mnt/user";
  appdataDir = "/mnt/user/appdata";
  mediaDir = "/mnt/user/media";
in 
{
  users.users.share = {
    isSystemUser= true;
    group = "share";
    extraGroups = [ "video" "render" ];
  };

  users.groups.share = {};

  imports = [
    ./arr.nix
    ./caddy.nix
    ./deluge.nix
    ./homepage.nix
    ./immich.nix
    ./jellyfin.nix
    ./mergerfs.nix
    ./paperless.nix
    ./vaultwarden.nix
  ];
}
