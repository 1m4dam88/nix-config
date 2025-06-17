{ config, pkgs, inputs, username, ... }:

{
  services.nfsClient.enable = true;
  imports = [
    ./hardware-configuration.nix
    ./../../modules/nixos
  ];

  # Kernel and boot configuration
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
    # Enable AMD GPU monitoring and control
  };

  # Performance tuning
  powerManagement.cpuFreqGovernor = "performance";
  services.thermald.enable = true;

  # Overclocking/undervolting support
  boot.extraModprobeConfig = ''
    options amdgpu ppfeaturemask=0xffffffff
    options amdgpu overdrive=1
  '';

  system.stateVersion = "24.11";
}
