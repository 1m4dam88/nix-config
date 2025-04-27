{ pkgs, lib, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.loader = lib.mkDefault {
    systemd-boot.enable = lib.mkDefault true;
    efi.canTouchEfiVariables = lib.mkDefault true;
    systemd-boot.configurationLimit = lib.mkDefault 10;
  };
}
