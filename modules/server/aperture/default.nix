{ config, pkgs, lib, ... }:

let
  # Domain settings - replace with your actual domains
  baseDomain = "fagwar.win";
  jellyfinDomain = "media.${baseDomain}";
  forgejoDomain = "git.${baseDomain}";
  tunnelid = config.sops.secrets.adam-aperture-tunnel-id.path;
  emailSecret = config.sops.secrets.fagwar-email.path;
in
{
  services = {
    jellyfin.enable = true;

    forgejo = {
      enable = true;
      database.type = "postgres";
      lfs.enable = true;
      settings = {
        server = {
          DOMAIN = "git.fagwar.win";
          ROOT_URL = "https://${forgejoDomain}/";
          HTTP_PORT = 3000;
        };
        actions = {
          ENABLED = true;
          DEFAULT_ACTIONS_URL = "github";
        };
      };
    };

    cloudflared = {
      enable = true;
      tunnels = {
        "adam-aperture" = {
          credentialsFile = config.sops.secrets.adam-aperture-tunnel.path;
          ingress = {
            "${jellyfinDomain}" = {
              service = "http://localhost:8096";
            };
            "${forgejoDomain}" = {
              service = "http://localhost:3000";
            };
          };
          default = "http_status:404";
        };
      };
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults = {
      email = builtins.readFile config.sops.secrets.fagwar-email.path;
      dnsProvider = "cloudflare";
      credentialsFile = config.sops.secrets.fagwar-api-key.path;
      group = "acme";
      dnsResolver = "1.1.1.1:53";
    };
    certs = {
      "${jellyfinDomain}" = {
        domain = jellyfinDomain;
      };
      "${forgejoDomain}" = {
        domain = forgejoDomain;
      };
    };
  };

  # Environment setup
  environment.systemPackages = with pkgs; [
    cloudflared
  ];
}
