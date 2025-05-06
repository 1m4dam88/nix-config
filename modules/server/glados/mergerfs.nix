{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.mergerfs ];

  fileSystems."/mnt/disk1" = {
  device = "/dev/disk/by-uuid/14b1f117-e24f-4dba-a223-f3285164db28";
  fsType = "xfs";
  options = [ "defaults" "noatime" "nofail" ];
  };

  fileSystems."/mnt/disk2" = {
    device = "/dev/disk/by-uuid/c54fdb86-5813-4bfb-b9b6-8cea88fd98f7";
    fsType = "xfs";
    options = [ "defaults" "noatime" "nofail" ];
  };
  
  fileSystems."/mnt/disk3" = {
    device = "/dev/disk/by-uuid/f303d3b4-39c0-4fe2-a37c-17ac3cd960c0";
    fsType = "xfs";
    options = [ "defaults" "noatime" "nofail" ];
  };

  fileSystems."/mnt/cache1" = {
    device = "/dev/disk/by-uuid/e55e189c-ad2d-448e-afa8-dbf8dc3c2ba9";
    fsType = "btrfs";
    options = [ "defaults" "noatime" "ssd" "discard=async"];
  };

  fileSystems."/mnt/storage" = {
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

  fileSystems."/mnt/user" = {
    device = "/mnt/cache*:/mnt/user";
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
  
}
