{ config, pkgs, inputs, username, ... }:

{
  services.nfsClient.enable = true;
  imports = [
    ./hardware-configuration.nix
    ./../../modules/nixos
  ];

  boot = {
    kernelParams = [ 
      "amd_iommu=on" 
      "iommu=pt" 
      "pcie_aspm=off" # Better PCIe performance
      "mitigations=off" # For maximum performance
    ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 1;
    };
  };

  hardware = {
    cpu.amd.updateMicrocode = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  powerManagement.cpuFreqGovernor = "performance";
  services.thermald.enable = true;

  boot.extraModprobeConfig = ''
    options amdgpu ppfeaturemask=0xffffffff
    options amdgpu overdrive=1
  '';

  system.stateVersion = "24.11";
}
