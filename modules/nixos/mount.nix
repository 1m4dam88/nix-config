{
  boot.supportedFilesystems = [ "nfs" ];
  services.rpcbind.enable = true; # needed for NFS

  systemd.mounts = [{
    type = "nfs";
    mountConfig = {
      Options = ["noatime" "nfsvers=4.2"];
    };
    what = "10.1.10.3:/";
    where = "/media/NAS";
  }];

  systemd.automounts = [{
    wantedBy = [ "multi-user.target" ];
    automountConfig = {
      TimeoutIdleSec = "600";
    };
    where = "/media/NAS";
  }];
}

