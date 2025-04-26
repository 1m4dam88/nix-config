{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/nixos
    ./disko-config.nix
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
        PasswordAuthentication = true;
        PermitRootLogin = "no";
      };
    };
  };

  system.stateVersion = "24.11";
}
