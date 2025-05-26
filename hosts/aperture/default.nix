{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/nixos
    ./disko-config.nix
    ./../../modules/server/aperture
  ];

  # Boot Configuration
  boot = {
    initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "sd_mod" ];
    kernelParams = [
      "intel_iommu=on"       # Enable IOMMU for virtualization
      "iommu=pt"             # Pass-through for devices
      "mitigations=off"      # Disable for bare-metal performance
      "nowatchdog"           # Disable hardware watchdog
      "quiet"                # Clean boot output
    ];
  };

  # Hardware Configuration
  hardware = {
    cpu.intel.updateMicrocode = true;
    enableAllFirmware = true;
    
    # Kaby Lake specific
    graphics.extraPackages = with pkgs; [ intel-media-driver vaapiIntel ];
  };

  # Performance Tuning
  powerManagement.cpuFreqGovernor = "performance";
  services.thermald.enable = true;

  # Essential Services
  services = {
    smartd.enable = true;

    # SSH access
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
      };
    };
  };

  system.stateVersion = "24.11";
}
