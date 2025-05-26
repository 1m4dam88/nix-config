{ config, pkgs, lib, ... }:
let
  email = "${config.sops.secrets.imadam-email.path}";
  api = "${config.sops.secrets.cloudflare_api_token.path}";
in
{
  security.acme = {
    acceptTerms = true;
    defaults.email = builtins.readFile email;
    certs."${config.homelab.domain}" = {
      domain = config.homelab.domain;
      extraDomainNames = [ "*.${config.homelab.domain}" ];
      dnsProvider = "cloudflare";
      group = "acme";
      dnsResolver = "1.1.1.1:53";
      dnsPropagationCheck = true;
      environmentFile = api;
    };
  };

  services.caddy = {
    enable = true;
    group = "acme";
    user = "acme";
    virtualHosts = {
      "homepage.tjd.lol" = {
        useACMEHost = "tjd.lol";
        extraConfig = ''
          reverse_proxy localhost:8082
        '';
      };
      "jellyfin.tjd.lol" = {
        useACMEHost = "tjd.lol";
        extraConfig = ''
          reverse_proxy 10.1.10.3:8096
        '';
      };
      "jellyseerr.tjd.lol" = {
        useACMEHost = "tjd.lol";
        extraConfig = ''
          reverse_proxy 10.1.10.3:5055
        '';
      };
      "sonarr.tjd.lol" = {
        useACMEHost = "tjd.lol";
        extraConfig = ''
          reverse_proxy 10.1.10.3:8989
        '';
      };
      "radarr.tjd.lol" = {
        useACMEHost = "tjd.lol";
        extraConfig = ''
          reverse_proxy 10.1.10.3:7878
        '';
      };
      "prowlarr.tjd.lol" = {
        useACMEHost = "tjd.lol";
        extraConfig = ''
          reverse_proxy 10.1.10.3:9696
        '';
      };
      "deluge.tjd.lol" = {
        useACMEHost = "tjd.lol";
        extraConfig = ''
          reverse_proxy 10.1.10.3:8112
        '';
      };
      "immich.tjd.lol" = {
        useACMEHost = "tjd.lol";
        extraConfig = ''
          reverse_proxy 10.1.10.3:2283
        '';
      };
      "paperless.tjd.lol" = {
        useACMEHost = "tjd.lol";
        extraConfig = ''
          reverse_proxy 10.1.10.3:28981
        '';
      };
      "vaultwarden.tjd.lol" = {
        useACMEHost = "tjd.lol";
        extraConfig = ''
          reverse_proxy 10.1.10.3:8000
        '';
      };
      "searx.tjd.lol" = {
        useACMEHost = "tjd.lol";
        extraConfig = ''
          reverse_proxy 10.1.10.3:8080
        '';
      };
      "slskd.tjd.lol" = {
        useACMEHost = "tjd.lol";
        extraConfig = ''
          reverse_proxy 10.1.10.3:5030
        '';
      };
      "homeassistant.tjd.lol" = {
        useACMEHost = "tjd.lol";
        extraConfig = ''
          reverse_proxy homeassistant.local:8123
        '';
      };
      "proxmox.tjd.lol" = {
        useACMEHost = "tjd.lol";
        extraConfig = ''
          reverse_proxy https://10.1.10.2:8006 {
           transport http {
             tls_insecure_skip_verify
           }
          }
        '';
      };
      "router.tjd.lol" = {
        useACMEHost = "tjd.lol";
        extraConfig = ''
          reverse_proxy https://10.1.10.1:443 {
            transport http {
             tls_insecure_skip_verify
            }
          }
        '';
      };
      "adguard.tjd.lol" = {
        useACMEHost = "tjd.lol";
        extraConfig = ''
          reverse_proxy 10.1.10.1:3000
        '';
      };
    };
  };
}

