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
            right = [  "volume" "battery" "systray" "network" "clock" ];
          };
          "1" = {
            left = [ "media" ];
            middle = [ "workspaces" ];
            right = [  "volume" "clock" ];
          };
          "2" = {
            left = [ "media" ];
            middle = [ "workspaces" ];
            right = [  "volume" "clock" ];
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
                      "11" = "󰙯";
                      "21" = "";
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
          outer_spacing = "0.5em";
          buttons = {
            enableBorders = false;
            spacing = "0.2em";
            y_margins = "0.1em";
            padding_y = "0.1rem";
          };
          location = "bottom";
          transparent = true;
        };
      };
    };
  };
}
