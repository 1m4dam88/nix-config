{ config, pkgs, ... }:
{
  fileSystems."/export/share" = {
    device = "/mnt/user";
    options = [ "bind" ];
  };
  services.nfs = {
    server = {
      enable = true;
      exports = ''
        /export/share 10.1.10.0/16(rw,sync,nohide,insecure,fsid=0,no_subtree_check)
      '';
    };
  };

  services = {
    samba = {
      enable = false;
      package = pkgs.samba4Full;
      settings = {
        global = {
          security = "user";
          interfaces = "lo enp9s0";
          "browseable" = "yes";
          "server min protocol" = "NT1";
          "passwd program" = "/run/wrappers/bin/passwd %u";
          "lanman auth" = "yes";
          "ntlm auth" = "yes";
          "bind interfaces only" = "yes";
        };
        storage = {
          path = "${config.homelab.storageDir}";
          writable = "true";
          comment = "NAS Storage share";
          browseable = "yes";
          "read only" = "no";
          "guest ok" = "no";
        };
        old = {
          path = "${config.homelab.storageDir}";
          writable = "true";
          comment = "NAS Storage share";
          browseable = "yes";
          "read only" = "no";
          "guest ok" = "no";
        };
      };
    };
    avahi = {
      enable = true;
      publish = {
        enable = true;
        userServices = true;
      };
    };
    samba-wsdd = {
      enable = true;
    };
  };
}
