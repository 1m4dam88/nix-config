{ inputs, config, pkgs, ... }:
{
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    package = pkgs.steam.override { 
      extraEnv = {
        MANGOHUD = true;
        OBS_VKCAPTURE = true;
      };
    };
  };

  hardware = {
    steam-hardware.enable = true;
  };
}
