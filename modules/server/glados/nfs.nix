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
}
