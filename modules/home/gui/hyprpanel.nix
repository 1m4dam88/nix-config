{ inputs, ... }:
{
  imports = [ inputs.hyprpanel.homeManagerModules.hyprpanel ];

  programs.hyprpanel = {
    enable = true;
    hyprland.enable = true;
    overlay.enable = true;
    settings = {
    layout = {
        "bar.layouts" = {
          "0" = {
            left = [ "dashboard" "media" "windowtitle" ];
            middle = [ "workspaces" ];
            right = [ "volume" "network" "battery" "systray" "clock" ];
          };
        };
      };
      menus.clock = {
        time = {
          military = true;
        };
        weather.unit = "metric";
      };
      wallpaper = {
        enable = true;
        image = "~/nix-config/wallpapers/urban_architecture.jpg";
        pywal = false;
      };
      bar = {
        launcher.autoDetectIcon = true;
        workspaces = {
          showWsIcons = true;
          workspaceIconMap = {
                      "1" = "";
                      "2" = "";
                      "3" = "";
                      "4" = "";
                      "5" = "";
          };
        };
      };
      theme = {
        matugen = false;
        name = "gruvbox";
        font = {
          name = "Caskaydia Cove Nerd Font";
          size = "13px";
        };
        bar = {
          buttons = {
            enableBorders = false;
            spacing = "0";
          };
          location = "bottom";
          transparent = false;
        };
      };
    };
  };
}
