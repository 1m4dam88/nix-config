{ ... }:
{
  wayland.windowManager.hyprland = {
     settings = {
       animations = {
         enabled = false;
       };
       decoration = {
         rounding = 10;
         active_opacity = 1;
         inactive_opacity = 1;
         blur = {
           enabled = false;
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
           range = 30;
           render_power = 3;
           offset = "12 12";
         };
       };
     };
  };
}
