{ config, lib, pkgs, ... }:

{
  # Kernel-level NFS support with modern protocol versions
  boot.supportedFilesystems = [ "nfs" "nfs4" ];
  boot.kernelModules = [ "nfs" "nfsd" ];

  # Essential NFS services
  services = {
    rpcbind.enable = true;
    nfs.server.enable = false;  # Disable if not acting as NFS server
    nfs.client = {
      enable = true;
      package = pkgs.nfs-utils;
    };
  };

  # Optimized NFS mount with performance tuning
  fileSystems."/media/NAS" = {
    device = "10.1.10.3:/";
    fsType = "nfs4";
    options = [
      # Protocol options
      "nfsvers=4.2"       # Modern protocol version
      "tcp"               # More reliable than UDP
      "noatime"           # Reduce disk writes
      "nodiratime"        # Further reduce metadata writes
      
      # Performance tuning
      "rsize=65536"       # Read size (bytes)
      "wsize=65536"       # Write size (bytes)
      "hard"              # Robust error handling
      "timeo=600"         # Timeout (deciseconds)
      "retrans=5"         # Retry attempts
      "bg"                # Background mounting
      "intr"              # Allow interruptible operations
      
      # Security
      "sec=krb5p"         # Highest security (adjust as needed)
      "noacl"             # Disable ACLs unless needed
      
      # Caching
      "lookupcache=all"   # Aggressive name caching
      "actimeo=300"       # Attribute cache timeout (seconds)
    ];
  };

  # Auto-mount configuration with fail-safes
  systemd.automounts = [{
    where = "/media/NAS";
    wantedBy = [ "multi-user.target" ];
    automountConfig = {
      TimeoutIdleSec = "300";  # More aggressive unmount
      DirectoryMode = "0755";
    };
  }];

  # Kernel network tuning
  boot.kernel.sysctl = {
    "sunrpc.tcp_slot_table_entries" = 128;  # Increase NFS connection slots
    "fs.nfs.nfs_congestion_kb" = 252144;    # 256MB congestion window
  };

  # Optional: Client-side caching for better performance
}
