{ config, pkgs, inputs, username, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/nixos
    ./disko-config.nix
  ];

  # Boot Configuration
  boot = {
    kernelModules = [ "acpi_call" "tp_smapi" ];
    extraModulePackages = with config.boot.kernelPackages; [ acpi_call tp_smapi ];
    kernelParams = [
      "i915.enable_rc6=1"       # Intel GPU power savings
      "i915.enable_fbc=1"       # Framebuffer compression
      "mem_sleep_default=deep"  # Better sleep states
      "pcie_aspm=off"           # Disable for stability
    ];
  };

  # Hardware Configuration
  hardware = {
    # Intel HD 4000 graphics
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        vaapiIntel
        libvdpau-va-gl
        intel-media-driver
      ];
    };

    # Enable all firmware
    enableAllFirmware = true;
  };

  # Power Management
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
    powertop.enable = true;
  };

  services = {
    # Thermal management
    thermald.enable = true;
    
    # TLP for power management
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        START_CHARGE_THRESH_BAT0 = 80;
        STOP_CHARGE_THRESH_BAT0 = 90;
      };
    };

    # For the fingerprint reader
    fprintd.enable = true;

    # Automatic CPU frequency scaling
    auto-cpufreq.enable = true;
  };

  security.pam.services.hyprlock = {};
  security.pam.services.hyprlock.fprintAuth = true;

  # Essential Tools
  environment.systemPackages = with pkgs; [
    # Hardware monitoring
    intel-gpu-tools
    lm_sensors
    powertop
    acpi

    # ThinkPad utilities
    thinkfan
    tpacpi-bat
  ];

  system.stateVersion = "24.11";
}
