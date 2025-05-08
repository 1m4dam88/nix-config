{ config, pkgs, ... }:
{
  fileSystems = {
    "/mnt/cache1" = {
      device = "/dev/disk/by-uuid/nvme-CT1000P2SSD8_2230E64DC7F8-part1";
      fsType = "btrfs";
      options = [ "defaults" "noatime" "ssd" "discard=async" ];
    };
    
    "/mnt/cache2" = {
      device = "/dev/disk/by-uuid/UUID_OF_CACHE2";
      fsType = "btrfs";
      options = [ "defaults" "noatime" "nofail" ];
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
        "func.getattr=newest"
        "dropcacheonclose=true"
        "minfreespace=20G"
        "uid=994"
        "gid=993"
        "umask=002"
        "x-mount.mkdir"
        ];
    };

    "/mnt/user" = {
      device = "/mnt/cache*:/mnt/storage";
      fsType = "fuse.mergerfs";
      options = [
        "category.create=epff"
        "defaults"
        "allow_other"
        "moveonenospc=1"
        "minfreespace=20G"
        "func.getattr=newest"
        "fsname=user"
        "uid=994"
        "gid=993"
        "umask=002"
        "x-mount.mkdir"
        ];
    };
  };
}
