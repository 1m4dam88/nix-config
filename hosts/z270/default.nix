{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/nixos
  ];

  # Boot Configuration
  boot = {
    kernelParams = [
      "intel_iommu=on"       # Enable IOMMU for virtualization
      "iommu=pt"             # Pass-through for devices
      "mitigations=off"      # Disable for bare-metal performance
      "nowatchdog"           # Disable hardware watchdog
      "quiet"                # Clean boot output
    ];

    # Server-grade kernel
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "sd_mod" ];

  # Hardware Configuration
  hardware = {
    cpu.intel.updateMicrocode = true;
    enableAllFirmware = true;
    
    # Kaby Lake specific
    opengl.extraPackages = with pkgs; [ intel-media-driver vaapiIntel ];
  };

  # Performance Tuning
  powerManagement.cpuFreqGovernor = "performance";
  services.thermald.enable = true;

  # Essential Services
  services = {
    # Hardware monitoring
    lm_sensors.enable = true;
    smartd.enable = true;

    # SSH access
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
  };

  system.stateVersion = "24.11";
}
