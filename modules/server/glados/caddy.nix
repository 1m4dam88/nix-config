{ config, pkgs, lib, ... }:
let
  reverseProxy = host: port: ''
    reverse_proxy ${host}:${toString port}
  '';
in
{
  security.acme = {
    acceptTerms = true;
    defaults.email = "adamg5333@proton.me";
    certs."${config.homelab.domain}" = {
      domain = config.homelab.domain;
      reloadServices = [ "caddy.service" ];
      extraDomainNames = [ "*.${config.homelab.domain}" ];
      dnsProvider = "cloudflare";
      credentialsFile = "${config.sops.secrets.tjd-api-key.path}";
      group = "acme";
      dnsResolver = "1.1.1.1:53";
    };
  };

  services.caddy = {
    enable = true;
    user = "acme";
    group = "acme";
    email = builtins.readFile "${config.sops.secrets.imadam-email.path}";
    virtualHosts = lib.genAttrs [
      "jellyfin" "sonarr" "radarr" "prowlarr" "deluge" 
      "immich" "paperless" "vaultwarden" "homeassistant"
    ] (name: {
      useACMEHost = config.homelab.domain;
      extraConfig = reverseProxy "localhost" (
        if name == "jellyfin" then 8096
        else if name == "sonarr" then 8989
        else if name == "radarr" then 7878
        else if name == "prowlarr" then 9696
        else if name == "deluge" then 8112
        else if name == "immich" then 2283
        else if name == "paperless" then 28981
        else if name == "vaultwarden" then 8000
        else if name == "homeassistant" then "10.1.10.181:8123"
        else 80
      );
    });
  };
}
