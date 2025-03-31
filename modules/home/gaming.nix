{ inputs, config, pkgs, ... }:
{
  programs.steam = {
    enable = true;
    gamescopeSession = enable;
  };
  environment.systemPackages = with pkgs; [mangohud protonup-qt lutris bottles heroic];
}
