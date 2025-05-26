{ lib, config, pkgs, inputs, username, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/nixos
  ];

  # Boot Configuration (Legacy BIOS recommended for X61)
  boot = {
    kernelParams = [
      "acpi_osi=Linux"       # Better ACPI compatibility
      "pcie_aspm=off"        # Disable ASPM for stability
      "i915.modeset=1"       # Intel graphics
      "consoleblank=30"      # Screen blank after 30s
    ];

    loader = {
      grub = {
        enable = true;
        version = 2;
        device = "/dev/sda"; # IDE/SATA disk
        useOSProber = true;
      };
    };
  };

  # Hardware Configuration
  hardware = {
    enableRedistributableFirmware = true;
    
    # Intel GMA X3100 graphics
    graphics = {
      enable = true;
      extraPackages = with pkgs; [ vaapiIntel ];
    };

    # Enable all available firmware
    firmware = [ pkgs.firmwareLinuxNonfree ];
  };

  # Performance Tuning
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
    powertop.enable = true;
  };

  services = {
    # Thermal management (critical for X61)
    thermald.enable = true;
  };

  # Lightweight Environment
  environment.systemPackages = with pkgs; [
    # Hardware tools
    acpi
    lm_sensors
    htop
  ];

  system.stateVersion = "24.11"; # Consider older version for better compatibility
}
