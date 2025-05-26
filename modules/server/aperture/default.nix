{ config, pkgs, lib, ... }:

let
  # Domain settings - replace with your actual domains
  baseDomain = "fagwar.win";
  jellyfinDomain = "media.${baseDomain}";
  gitDomain = "git.${baseDomain}";
  gitsshDomain = "git-ssh.${baseDomain}";
  tunnelid = config.sops.secrets.adam-aperture-tunnel-id.path;
  emailSecret = config.sops.secrets.fagwar-email.path;
  forgejoDir = "/mnt/storage/forgejo";
in
{
  imports = [
    ./disks.nix
  ];
  services = {
    jellyfin.enable = true;

    forgejo = {
      enable = true;
      database.type = "postgres";
      lfs.enable = true;
      stateDir = "${forgejoDir}/state";
      repositoryRoot = "${forgejoDir}/repositories";
      lfs.contentDir = "${forgejoDir}/lfs";
      dump = {
        backupDir = "${forgejoDir}/backups";
      };

      settings = {
        server = {
          DOMAIN = "${gitDomain}";
          ROOT_URL = "https://${gitDomain}/";
          SSH_DOMAIN = "${gitsshDomain}";
          SSH_PORT = 3222;
          SSH_LISTEN_PORT = 3222;
          HTTP_PORT = 3000;
        };
        repository = {
          ROOT = "${forgejoDir}/repositories";
        };
        lfs = {
          PATH = "${forgejoDir}/lfs";
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
            "${gitDomain}" = {
              service = "http://localhost:3000";
            };
            "${gitsshDomain}" = {
              service = "ssh://localhost:3222";
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
      "${gitDomain}" = {
        domain = gitDomain;
      };
    };
  };

    systemd.tmpfiles.rules = [
    "d ${forgejoDir} 0750 forgejo forgejo - -"
    "d ${forgejoDir}/state 0750 forgejo forgejo - -"
    "d ${forgejoDir}/repositories 0750 forgejo forgejo - -"
    "d ${forgejoDir}/lfs 0750 forgejo forgejo - -"
    "d ${forgejoDir}/backups 0750 forgejo forgejo - -"
  ];

  # Environment setup
  environment.systemPackages = with pkgs; [
    cloudflared
  ];
}
