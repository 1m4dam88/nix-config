
{ config, pkgs, inputs, username, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/nixos
  ];

  boot = {
    kernelModules = [ "acpi_call" "tp_smapi" ];
    extraModulePackages = with config.boot.kernelPackages; [ 
      acpi_call 
      tp_smapi 
    ];
    kernelParams = [
      "pcie_aspm=off"
      "i915.enable_rc6=1"
      "i915.enable_fbc=1"
    ];
  };

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
    };
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "performance";
    powertop.enable = true;
  };

  services = {
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

    optimus-manager = {
      enable = config.hardware.nvidia.enable;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  security.pam.services.hyprlock = {};
  security.pam.services.hyprlock.fprintAuth = true;

  system.stateVersion = "24.11";
}
