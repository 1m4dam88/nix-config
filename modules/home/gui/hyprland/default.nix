{ inputs, pkgs, self, config, ... }:
{
  imports = [
    ./hyprlock.nix
    ./hypridle.nix
    ./source
  ];


  gtk.iconTheme = {
    name = "Gruvbox-Plus-Dark";
    package = pkgs.gruvbox-plus-icons;
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

  stylix.targets.mako.enable = false;

  services.hyprsunset = {
    enable = true;
    transitions = {
      sunrise = {
        calendar = "*-*-* 06:00:00";
        requests = [
          [ "temperature" "6500" ]
          [ "gamma 100" ]
        ];
      };
      sunset = {
        calendar = "*-*-* 22:30:00";
        requests = [
          [ "temperature" "3500" ]
        ];
      };      
    };
  };

  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
    };
  };
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    plugins = [
      inputs.split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces
    ];

    xwayland = {
      enable = true;
    };
  };
}
