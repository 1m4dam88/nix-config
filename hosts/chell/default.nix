{ config, pkgs, inputs, username, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/nixos
  ];

  # Boot Configuration
  boot = {
    kernelParams = [
      "i915.enable_rc6=1"   # Intel GPU power savings
      "i915.enable_fbc=1"   # Frame buffer compression
      "mitigations=off"     # Better performance for this trusted device
    ];
  };

  # Hardware Configuration
  hardware = {
    # Intel Haswell optimizations
    cpu.intel.updateMicrocode = true;
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        vaapiIntel
        libvdpau-va-gl
        intel-media-driver
      ];
      driSupport = true;
      enable32Bit = true;
    };

    # Enable all firmware
    enableAllFirmware = true;
  };

  # Performance Tuning
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
  };

  services = {
    # Thermal management for the compact form factor
    thermald.enable = true;
    
    # Hardware monitoring
    lm_sensors.enable = true;
  };

  # Essential Tools
  environment.systemPackages = with pkgs; [
    # Hardware monitoring
    intel-gpu-tools
    lm_sensors
    htop
    powertop

    # System utilities
    pciutils
    usbutils
    dmidecode
  ];

  system.stateVersion = "24.11";
}
