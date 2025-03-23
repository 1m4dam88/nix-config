# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./../../modules/nixos
    ];
   
   environment.systemPackages = with pkgs; [
     acpi
     brightnessctl
     cpupower-gui
     powertop
   ];

   services = {
     power-profiles-daemon.enable = true;

     upower = {
       enable = true;
       percentageLow = 20;
       percentageCritical = 5;
       percentageAction = 3;
       criticalPowerAction = "PowerOff";
    };

    tlp.settings = {
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 1;

      PLATFORM_PROFILE_ON_BAT = "performance";
      PLATFORM_PROFILE_ON_AC = "performance";
    };
  };

  powerManagement.cpuFreqGovernor = "performance";

  boot = {
    kernelModules = [ "acpi_call" ];
    extraModulePackages =
      with config.boot.kernelPackages;
      [
        acpi_call
	cpupower
      ]
      ++ [  pkgs.cpupower-gui ];
  };
} 
