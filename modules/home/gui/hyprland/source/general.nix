{ config, lib, ... }:
{
  wayland.windowManager.hyprland = {
     settings = {
       general = {
         "$mainMod" = "SUPER";
         layout = "dwindle";
         gaps_in = 10;
         gaps_out = 20;
         border_size = 3;
         "col.active_border" = lib.mkForce "rgb(${config.lib.stylix.colors.base04})";
         "col.inactive_border" = lib.mkForce "rgba(${config.lib.stylix.colors.base09}00)";
       };
     };
  };
}
