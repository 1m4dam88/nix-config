{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/nixos
    ./disko-config.nix
    ./../../modules/server/proxvm
  ];

  # Boot Configuration
  boot = {
    kernelParams = [
      "mitigations=off"      # Disable for bare-metal performance
      "nowatchdog"           # Disable hardware watchdog
      "quiet"                # Clean boot output
    ];
  };

  # Hardware Configuration
  hardware = {
    enableAllFirmware = true;
  };

  # Performance Tuning
  powerManagement.cpuFreqGovernor = "performance";

  # Essential Services
  services = {
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "yes";
      };
    };
  };

  system.stateVersion = "24.11";
}
