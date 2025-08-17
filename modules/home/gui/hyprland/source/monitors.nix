{ ... }:
{
  wayland.windowManager.hyprland = {
    extraConfig = "
      monitor=DP-1,3440x1440@165.0,1920x167,1.0
      monitor=DP-2,1920x1200@59.95,5360x0,1.0
      monitor=DP-2,transform,1
      monitor=DP-3,1920x1080@60.0,0x293,1.0
      monitor=eDP-1,3840x2160@60,auto,1.5
      monitor=LVDS-1,1920x1080@60,auto,1
    ";
 };
}
