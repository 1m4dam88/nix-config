{ config, pkgs, lib, ... }:
{
  services = {
    slskd = {
      enable = true;
      domain = "slskd.${config.homelab.domain}";
      nginx.listen.tjd.lol.port = "1488";
      environmentFile = "${config.sops.secrets.slskd.path}";
      settings = {
        shares.directories = [ "${config.homelab.mediaDir}/Music/downloads" ];
        directories.downloads = "${config.homelab.mediaDir}/Music/downloads";
      };
    };
  };
}
