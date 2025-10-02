{ config, lib, ... }:
{
  wayland.windowManager.hyprland = {
     settings = {
       animations = {
         enabled = false;
       };
       decoration = {
         active_opacity = 1;
         inactive_opacity = 1;
         blur = {
           enabled = true;
           size = 10;
           passes = 3;
           new_optimizations = true;
           xray = true;
           ignore_opacity = true;
           brightness = 0.90;
           noise = 0;
         };
         shadow = {
           enabled = true;
           offset = "12 12";
           color = lib.mkForce "rgba(${config.lib.stylix.colors.base00}ff)";
         };
       };
     };
  };
}
