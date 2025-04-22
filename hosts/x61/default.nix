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

  boot.loader = {
    grub = {
      device = "/dev/sda";
    };
  };
   
   environment.systemPackages = with pkgs; [
     acpi
     brightnessctl
     cpupower-gui
     powertop
   ];

   services = {
  };
  powerManagement.cpuFreqGovernor = "performance";
} 
