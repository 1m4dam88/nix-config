{ config, pkgs, lib, ... }:
{
  services = {
    slskd = {
      enable = true;
      domain = "slskd.${config.homelab.domain}";
      environmentFile = "${config.sops.secrets.slskd.path}";
      settings = {
        shares.directories = [ "${config.homelab.mediaDir}/Music/share" ];
        directories.downloads = "${config.homelab.mediaDir}/Music/downloads";
      };
      nginx.listen = [
        {
          addr = "10.1.10.3";
          port = 4343;
          ssl = true;
        }
        {
          addr = "10.1.10.3";
          port = 1488;
        }
      ];
    };
  };
}
