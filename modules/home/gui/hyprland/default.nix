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
    bemoji
    brightnessctl
    cliphist
    direnv
    glib
    grim
    hyprpicker
    matugen
    playerctl
    slurp
    swww
    wayland
    wf-recorder
    wl-clipboard
    wtype
  ];

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

  systemd.user.targets.hyprland-session.Unit.Wants = [
    "xdg-desktop-autostart.target"
  ];

  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
      config = {
        common.default = [ "gtk" ];
        hyprland.default = [
          "gtk"
          "hyprland"
        ];
      };
    };
  };
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    systemd.enable = true;
    systemd.enableXdgAutostart = true;
    plugins = [
      inputs.split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces
    ];

    xwayland = {
      enable = true;
    };
  };
}
