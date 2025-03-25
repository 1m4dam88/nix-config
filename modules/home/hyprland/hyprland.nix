{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    inputs.hypr-contrib.packages.${pkgs.system}.grimblast
    swww
    hyprpicker
    hyprlock
    bemoji
    grim
    slurp
    cliphist
    wf-recorder
    wl-clipboard
    playerctl
    glib
    wayland
    direnv
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
    systemd.enable = true;
  };
}
