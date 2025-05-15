{ config, pkgs, ... }:
let
  email = "${config.sops.secrets.imadam-email.path}";
  api = "${config.sops.secrets.tjd-api-key.path}";
in
{
  security.acme = {
    acceptTerms = true;
    defaults.email = "adamg5333@proton.me";
    certs = {
      "tjd.lol" = {
        domain = "tjd.lol";
        reloadServices = [ "caddy.service" ];
        extraDomainNames = [ "*.tjd.lol" ];
        dnsProvider = "cloudflare";
        credentialsFile = "${config.sops.secrets.tjd-api-key.path}";
        group = "acme";
        dnsResolver = "1.1.1.1:53";
      };
    };
  };

  services.caddy = {
    enable = true;
    user = "acme";
    group = "acme";
    email = builtins.readFile email;
    virtualHosts = {
      "jellyfin.tjd.lol" = {
        useACMEHost = "tjd.lol";
        extraConfig = ''
          reverse_proxy localhost:8096
        '';
      };
      "sonarr.tjd.lol" = {
        useACMEHost = "tjd.lol";
        extraConfig = ''
          reverse_proxy localhost:8989
        '';
      };
      "radarr.tjd.lol" = {
        useACMEHost = "tjd.lol";
        extraConfig = ''
          reverse_proxy localhost:7878
        '';
      };
      "prowlarr.tjd.lol" = {
        useACMEHost = "tjd.lol";
        extraConfig = ''
          reverse_proxy localhost:9696
        '';
      };
      "deluge.tjd.lol" = {
        useACMEHost = "tjd.lol";
        extraConfig = ''
          reverse_proxy localhost:8112
        '';
      };
      "immich.tjd.lol" = {
        useACMEHost = "tjd.lol";
        extraConfig = ''
          reverse_proxy localhost:2283
        '';
      };
      "paperless.tjd.lol" = {
        useACMEHost = "tjd.lol";
        extraConfig = ''
          reverse_proxy localhost:28981
        '';
      };
      "vaultwarden.tjd.lol" = {
        useACMEHost = "tjd.lol";
        extraConfig = ''
          reverse_proxy localhost:8000
        '';
      };
      "homeassistant.tjd.lol" = {
        useACMEHost = "tjd.lol";
        extraConfig = ''
          reverse_proxy 10.1.10.181:8123
        '';
      };
    };
  };
}

