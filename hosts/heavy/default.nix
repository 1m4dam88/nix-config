
{ config, pkgs, inputs, username, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/nixos
  ];

  # Boot Configuration
  boot = {
    kernelModules = [ "acpi_call" "tp_smapi" ];
    extraModulePackages = with config.boot.kernelPackages; [ 
      acpi_call 
      tp_smapi 
    ];
    kernelParams = [
      "pcie_aspm=off"       # Better performance for older PCIe
      "i915.enable_rc6=1"   # Intel GPU power savings
      "i915.enable_fbc=1"   # Frame buffer compression
    ];
  };

#    # For the Nvidia Quadro if present
#    nvidia = {
#      modesetting.enable = true;
#      powerManagement.enable = true;
#    };
#  };

  # Power Management
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
    powertop.enable = true;
  };

  services = {
    # Thermal management
    thermald.enable = true;
    fprintd.enable = true;
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        START_CHARGE_THRESH_BAT0 = 75;
        STOP_CHARGE_THRESH_BAT0 = 85;
      };
    };
  };

    # For the fingerprint reader if present

#    # Enable Optimus manager if using Nvidia/Intel hybrid
#    optimus-manager = {
#      enable = config.hardware.nvidia.enable;
#      intelBusId = "PCI:0:2:0";
#      nvidiaBusId = "PCI:1:0:0";
#    };
#  };

  # Hardware Video Acceleration
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  # Essential Tools
  environment.systemPackages = with pkgs; [
    # ThinkPad utilities
    thinkfan
    acpi
    tpacpi-bat

  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken.
  system.stateVersion = "24.11";
}
