{ config, pkgs, inputs, username, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/nixos
    ./../../modules/server/glados/default.nix
    ./disko-config.nix
  ];

  services.nfsClient.enable = false;

  # Kernel and boot configuration
  boot = {
    kernelModules = [ "kvm-amd" ];
    kernelParams = [ 
      "amd_iommu=on" 
      "iommu=pt" 
      "pcie_aspm=off" # Better PCIe performance
      "mitigations=off" # For maximum performance
    ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 1; # Faster boot
    };
  };

  # AMD hardware configuration
  hardware = {
    cpu.amd.updateMicrocode = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  services.openssh.enable = true;

  # Performance tuning
  powerManagement.cpuFreqGovernor = "performance";
  services.thermald.enable = true;

  system.stateVersion = "24.11";
}
