{ inputs, pkgs, self, config, ... }:
{
  imports = [
    ./hyprlock.nix
    ./hypridle.nix
    ./source
  ];
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
  home.packages = with pkgs; [
    inputs.hypr-contrib.packages.${pkgs.system}.grimblast
    swww
    hyprpicker
    bemoji
    wtype
    grim
    slurp
    cliphist
    wf-recorder
    wl-clipboard
    playerctl
    glib
    wayland
    direnv
    matugen
  ];
  systemd.user.targets.hyprland-session.Unit.Wants = [
    "xdg-desktop-autostart.target"
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;

    plugins = [
      inputs.split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces
    ];

    xwayland = {
      enable = true;
    };
  };
}
