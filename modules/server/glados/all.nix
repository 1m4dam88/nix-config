{ config, pkgs, ... }:
{
  services = {
    sonarr = {
      enable = true;
      dataDir = "/mnt/user/appdata/sonarr";
      user = "share";
      group = "share";
    };
    radarr = {
      enable = true;
      dataDir = "/mnt/user/appdata/radarr";
      user = "share";
      group = "share";
    };
    prowlarr = {
      enable = true;
    };
    flaresolverr = {
      enable = true;
    };
  };
}
{ config, pkgs, ... }:
let
  email = "${config.sops.secrets.imadam-email.path}";
  api = "${config.sops.secrets.tjd-api-key.path}";
in
{
  security.acme = {
    acceptTerms = true;
    defaults.email = "adamg5333@proton.me";
    certs = {
      "tjd.lol" = {
        domain = "tjd.lol";
        reloadServices = [ "caddy.service" ];
        extraDomainNames = [ "*.tjd.lol" ];
        dnsProvider = "cloudflare";
        credentialsFile = "${config.sops.secrets.tjd-api-key.path}";
        group = "acme";
        dnsResolver = "1.1.1.1:53";
      };
    };
  };

  services.caddy = {
    enable = true;
    user = "acme";
    group = "acme";
    email = builtins.readFile email;
    virtualHosts = {
      "jellyfin.tjd.lol" = {
        useACMEHost = "tjd.lol";
        extraConfig = ''
          reverse_proxy localhost:8096
        '';
      };
      "sonarr.tjd.lol" = {
        useACMEHost = "tjd.lol";
        extraConfig = ''
          reverse_proxy localhost:8989
        '';
      };
      "radarr.tjd.lol" = {
        useACMEHost = "tjd.lol";
        extraConfig = ''
          reverse_proxy localhost:7878
        '';
      };
      "prowlarr.tjd.lol" = {
        useACMEHost = "tjd.lol";
        extraConfig = ''
          reverse_proxy localhost:9696
        '';
      };
      "deluge.tjd.lol" = {
        useACMEHost = "tjd.lol";
        extraConfig = ''
          reverse_proxy localhost:8112
        '';
      };
      "immich.tjd.lol" = {
        useACMEHost = "tjd.lol";
        extraConfig = ''
          reverse_proxy localhost:2283
        '';
      };
      "paperless.tjd.lol" = {
        useACMEHost = "tjd.lol";
        extraConfig = ''
          reverse_proxy localhost:28981
        '';
      };
      "vaultwarden.tjd.lol" = {
        useACMEHost = "tjd.lol";
        extraConfig = ''
          reverse_proxy localhost:8000
        '';
      };
      "homeassistant.tjd.lol" = {
        useACMEHost = "tjd.lol";
        extraConfig = ''
          reverse_proxy 10.1.10.181:8123
        '';
      };
    };
  };
}

{ config, pkgs, lib, ... }:
let
  cfg = 
in 
{
  options.my.server = {
    enable = mkEnableOption "Enable";

    domain = mkOption {
      type = types.str;
      default = "tjd.lol";
      description = "Self hosted apps domain";
    };

    user = {
      name = mkOption {
        type = types.str;
        default = "share";
        description = "default user for selfhosted apps";
      };
      group = mkOption {
        type = types.str;
        default = "share";
        description = "default group for selfhosted apps";
      };
    };
  };
  users.users.share = {
    isSystemUser= true;
    group = "share";
    extraGroups = [ "video" "render" ];
  };

  users.groups.share = {};

  imports = [
    ./arr.nix
    ./caddy.nix
    ./deluge.nix
    ./homepage.nix
    ./immich.nix
    ./jellyfin.nix
    ./mergerfs.nix
    ./paperless.nix
    ./vaultwarden.nix
  ];
}
{ config, pkgs, lib, ... }:
{
  services = {
    deluge = {
      enable = true;
      web.enable = true;
      declarative = true;
      dataDir = "/mnt/user/appdata/deluge";
      authFile = "${config.sops.secrets.deluge.path}";
      group = "share";
      user = "share";
      config = {
        download_location = "/mnt/user/media/torrents";
      };
    };
  };
}
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
{ config, pkgs, lib, ... }:
{
  services = {
    immich = {
      enable = true;
      mediaLocation = "/mnt/user/media/immich-new/photos";
      accelerationDevices = null;
    };
  };
}
{ config, pkgs, lib, ... }:
{
  services = {
    jellyfin = {
      enable = true;
      configDir = "/mnt/user/appdata/jellyfin/config";
      logDir = "/mnt/user/appdata/jellyfin/config/log";
      cacheDir = "/mnt/user/appdata/jellyfin/config/cache";
      dataDir = "/mnt/user/appdata/jellyfin";
      user = "share";
      group = "share";
    };
  };

  systemd.services.jellyfin.after = [ "mnt-user.mount" ];
  systemd.services.jellyfin.requires = [ "mnt-user.mount" ];
  systemd.tmpfiles.rules = [
    "d /mnt/user/appdata/jellyfin 0775 share share -"
    "d /mnt/user/media/movies 0775 share share -"
    "d /mnt/user/media/shows 0775 share share -"
  ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ nvidia-vaapi-driver vaapiVdpau ];
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = false;
}
{ config, pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    mergerfs
  ];

  fileSystems = {
    "/mnt/cache1" = {
      device = "/dev/disk/by-id/nvme-CT1000P2SSD8_2230E64DC7F8-part1";
      fsType = "btrfs";
      options = [ "defaults" "noatime" "ssd" "discard=async" ];
    };
    
    "/mnt/disk1" = {
      device = "/dev/disk/by-id/ata-ST12000NM000J-2TY103_ZV707NAW-part1";
      fsType = "xfs";
      options = [ "defaults" "noatime" "nofail" ];
    };
    
    "/mnt/disk2" = {
      device = "/dev/disk/by-id/ata-ST2000DM008-2UB102_WFL5SBGX-part1";
      fsType = "xfs";
      options = [ "defaults" "noatime" "nofail" ];
    };
    
    "/mnt/disk3" = {
      device = "/dev/disk/by-id/ata-WDC_WD10EZEX-08WN4A0_WD-WCC6Y5EYSU3H-part1";
      fsType = "xfs";
      options = [ "defaults" "noatime" "nofail" ];
    };

    "/mnt/storage" = {
      device = "/mnt/disk*";
      fsType = "fuse.mergerfs";
      options = [
        "defaults"
        "allow_other"
        "moveonenospc=1"
        "minfreespace=0G"
        "func.getattr=newest"
        "fsname=mergerfs_slow"
        "umask=002"
        "x-mount.mkdir"
        ];
    };

    "/mnt/user" = {
      device = "/mnt/cache*:/mnt/storage";
      fsType = "fuse.mergerfs";
      options = [
        "category.create=mfs"
        "defaults"
        "allow_other"
        "moveonenospc=1"
        "minfreespace=0G"
        "func.getattr=newest"
        "fsname=user"
        "umask=002"
        "x-mount.mkdir"
        ];
    };
  };
}
{ config, pkgs, ... }:
{
  fileSystems."/export/share" = {
    device = "/mnt/user";
    options = [ "bind" ];
  };
  services.nfs.server = {
    enable = true;
    extraNfsdConfig = ''
      verd3=on
      vers4=on
      vers4.1=on
      vers4.2=on
    '';
    exports = ''
      /export/share         10.1.10.0/16(rw,fsid=0,no_subtree_check)
    '';
  };
}
PAPERLESS_ALLOWED_HOSTS="https://paperless.tjd.lol"
PAPERLESS_URL="https://paperless.tjd.lol"
{ config, pkgs, lib, ... }:
{
  services = {
    paperless = {
      enable = true;
      user = "share";
      dataDir = "/mnt/user/appdata/paperless";
      mediaDir = "/mnt/user/media/paperless/media";
      environmentFile = "/home/ye/nix-config/modules/server/glados/paperless-env";
    };
  };
}
{ config, pkgs, lib, ... }:
{
  services = {

  }
}
{ config, pkgs, lib, ... }:
{
  services = {
    vaultwarden = {
      enable = true;
      dbBackend = "sqlite";
      config = {
        DOMAIN = "https://vaultwarden.tjd.lol";
      };
    };
  };
}
