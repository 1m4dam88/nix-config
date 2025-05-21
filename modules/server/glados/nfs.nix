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
      /export/share 10.1.10.0/16(rw,sync,nohide,insecure,fsid=0,no_subtree_check)
    '';
  };
}
