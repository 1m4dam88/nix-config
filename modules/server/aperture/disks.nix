{ config, pkgs, ... }:

{
  # Enable Btrfs filesystem tools
  environment.systemPackages = with pkgs; [
    btrfs-progs
  ];

  # Filesystem configuration
  fileSystems = {
    # Mount the data subvolume
    "/mnt/storage" = {
      device = "/dev/disk/by-uuid/4b64d284-ad08-408c-bff7-eff40dde8783";
      fsType = "btrfs";
      options = [
        "subvol=@data"
        "compress=zstd"       # Efficient compression
        "noatime"            # Reduce write operations
        "discard=async"      # Better SSD TRIM handling
        "ssd"               # Optimize for SSD
        "space_cache=v2"     # Better performance for SSDs
        "commit=120"         # Group commits (reduces write amplification)
      ];
    };
  };

  # Enable periodic TRIM for SSDs (recommended)
  services.fstrim = {
    enable = true;
    interval = "weekly";
  };

  # Btrfs maintenance tasks (scrub, balance, etc.)
  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = [ "/mnt/storage" ];
  };

  # Systemd mount options for better SSD performance

  # Optional: Enable Btrfs quota support if you need it
  boot.kernelParams = [ "btrfs.allow_unsupported=1" ];
}
