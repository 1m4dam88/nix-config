{ config, pkgs, lib, ... }:
{
  services = {
    homepage-dashboard = {
      enable = true;
      services = [
        {
          "Media" = [
            {
              "Jellyfin" = {
                description = "Media Player";
                href = "https://jellyfin.tjd.lol";
                icon = "sh-jellyfin.svg";
              };
            }
          ];
        }
      ];
    };
  };
}
