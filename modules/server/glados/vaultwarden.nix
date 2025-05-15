{ config, pkgs, lib, ... }:
{
  services = {
    vaultwarden = {
      enable = true;
      dbBackend = "sqlite";
      config = {
        DOMAIN = "https://vaultwarden.tjd.lol";
      };
    };
  };
}
