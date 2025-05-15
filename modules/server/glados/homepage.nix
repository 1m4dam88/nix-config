{ config, pkgs, ... }:
{
  services.homepage-dashboard = {
    enable = true;
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
        ];
      }
    ];
  };
}
