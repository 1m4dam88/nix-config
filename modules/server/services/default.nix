{
  config,
  lib,
  pkgs,
  ...
};
{
  imports = [
    ./jellyfin.nix
  ];
  security.acme = {
    acceptTerms = true;
    defaults.email = "${config.sops.secrets.email}";
    certs.tjd.lol = {
      reloadServices = [ "caddy.service" ];
      domain = "tjd.lol";
      extraDomainNames = [ "*.tjd.lol" ];
      dnsProvider = "cloudflare";
      dnsResolver = "1.1.1.1:53";
      dnsPropagationCheck = true;
      group = config.services.caddy.group;
      environmentFile = config.homelab.cloudflare.dnsCredentialsFile;
    };
  };
  services.caddy = {
      enable = true;
      globalConfig = ''
        auto_https off
      '';
      virtualHosts = {
        "http://tjd.lol" = {
          extraConfig = ''
            redir https://{host}{uri}
          '';
        };
        "http://*.tjd.lol" = {
          extraConfig = ''
            redir https://{host}{uri}
          '';
        };
      };
  };

  services.cloudflared = {
    enable = true;
  };

  virtualisation.podman = {
    dockerCompat = true;
    autoPrune.enable = true;
    defaultNetwork.settings = {
      dns_enabled = true;
    };
  };
  virtualisation.oci-containers = {
    backend = "podman";
  };
}
