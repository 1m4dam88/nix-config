
{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ mergerfs ];

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

