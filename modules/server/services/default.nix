{
  config,
  lib,
  pkgs,
  ...
};
{
  security.acme = {
    acceptTerms = true;
    defaults.email = "${config.sops.secrets.email}";
    certs.${config.homelab.baseDomain} = {
      reloadServices = [ "caddy.service" ];
      domain = "${config.homelab.baseDomain}";
      extraDomainNames = [ "*.${config.homelab.baseDomain}" ];
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
        "http://${config.homelab.baseDomain}" = {
          extraConfig = ''
            redir https://{host}{uri}
          '';
        };
        "http://*.${config.homelab.baseDomain}" = {
          extraConfig = ''
            redir https://{host}{uri}
          '';
        };
      };
  };

  services.cloudflared = {
    enable = true;
  }

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
