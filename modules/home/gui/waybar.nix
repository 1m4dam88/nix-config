{ config, pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "left";
        height = 30;
        output = [
          "LVDS-1"
        ];
        modules-left = [ "hyprland/workspaces" "hyprland/mode" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "battery" "clock" ];
        battery = {
            format = "{capacity}% {icon}";
            format-icons = ["" "" "" "" ""];
        };
        clock = {
            format-alt = "{:%a, %d. %b  %H:%M}";
        };
      };
    };
  };
}
