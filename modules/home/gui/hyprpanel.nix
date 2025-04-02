{ inputs, ... }:
{
  imports = [ inputs.hyprpanel.homeManagerModules.hyprpanel ];

  programs.hyprpanel = {
    enable = true;
    systemd.enable = true;
    hyprland.enable = true;
    overlay.enable = true;
    settings = {
      menus.clock = {
        time = {
          military = true;
        };
        weather.unit = "metric";
      };
      wallpaper = {
        enable = true;
        image = "~/nix-config/wallpapers/blue.png";
        pywal = true;
      };
      bar = {
        launcher.autoDetectIcon = true;
        workspaces.show_icons = true;
      };
      theme = {
        matugen = true;
        font = {
          name = "Caskaydia Cove Nerd Font";
          size = "16px";
        };
        bar = {
          location = "bottom";
          buttons.enableBorders = true;
          transparent = true;
        };
      };
    };
  };
}
