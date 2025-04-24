{ config, pkgs, inputs, username, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/nixos/
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
    opengl = {
      enable = true;
      driSupport = true;
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
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_SCALING_GOVERNOR_ON_AC = "ondemand";
        START_CHARGE_THRESH_BAT0 = 75;
        STOP_CHARGE_THRESH_BAT0 = 85;
      };
    };
  };

  # Lightweight Environment
  environment.systemPackages = with pkgs; [
    # Hardware tools
    acpi
    tp_smapi
    lm_sensors
    htop
  ];

  system.stateVersion = "24.11"; # Consider older version for better compatibility
}
