{ config, pkgs, ... }:
{
  services.homepage-dashboard = {
    enable = true;
#    environmentFile = "/home/ye/nix-config/modules/server/proxvm/homepage.env";
    services = [
      {
        "Media" = [
          {
            "Jellyfin" = {
              description = "Media Player";
              href = "https://jellyfin.${config.homelab.domain}";
              icon = "sh-jellyfin.svg";
            };
          }
          {
            "Jellyseerr" = {
              description = "*arr Content downloader";
              href = "https://jellyseerr.${config.homelab.domain}";
              icon = "sh-jellyseerr.svg";
            };
          }
          {
            "Radarr" = {
              description = "Movie torrent indexer";
              href = "https://radarr.${config.homelab.domain}";
              icon = "sh-radarr.svg";
            };
          }
          {
            "Sonarr" = {
              description = "TV Show torrent indexer";
              href = "https://sonarr.${config.homelab.domain}";
              icon = "sh-sonarr.svg";
            };
          }
          {
            "Prowlarr" = {
              description = "Torrent site indexer";
              href = "https://prowlarr.${config.homelab.domain}";
              icon = "sh-prowlarr.svg";
            };
          }
          {
            "slskd" = {
              description = "Soulseek WebUI";
              href = "https://slskd.${config.homelab.domain}";
              icon = "sh-slskd.svg";
            };
          }
          {
            "Deluge" = {
              description = "Torrent Client";
              href = "https://deluge.${config.homelab.domain}";
              icon = "sh-deluge.svg";
            };
          }
        ];
      }
      {
        "Cloud" = [
          {
            "Immich" = {
              description = "Photo library";
              href = "https://immich.${config.homelab.domain}";
              icon = "sh-immich.svg";
            };
          }
          {
            "Home Assistant" = {
              description = "Home Assistant";
              href = "https://homeassistant.${config.homelab.domain}";
              icon = "sh-home-assistant.svg";
            };
          }
          {
            "Paperless" = {
              description = "PDF and Document organizer";
              href = "https://paperless.${config.homelab.domain}";
              icon = "sh-paperless.svg";
            };
          }
          {
            "Vaultwarden" = {
              description = "Bitwarden alternative";
              href = "https://vaultwarden.${config.homelab.domain}";
              icon = "sh-vaultwarden.svg";
            };
          }
          {
            "Homebox" = {
              description = "";
              href = "https://homebox.${config.homelab.domain}";
              icon = "sh-homebox.svg";
            };
          }
         # {
         #   "" = {
         #     description = "";
         #     href = "https://.${config.homelab.domain}";
         #     icon = "sh-.svg"
         #   };
         # }
        ];
      }
      {
        "Network" = [
          {
            "Router" = {
              description = "My router";
              href = "https://router.${config.homelab.domain}";
              icon = "sh-opnsense.svg";
            };
          }
          {
            "Adguard Home" = {
              description = "Ad Blocker";
              href = "https://adguard.${config.homelab.domain}";
              icon = "sh-adguard-home.svg";
            };
          }
          {
            "Proxmox" = {
              description = "Proxmox";
              href = "https://proxmox.${config.homelab.domain}";
              icon = "sh-proxmox.svg";
            };
          }
        ];
      }
    ];
  };
}
