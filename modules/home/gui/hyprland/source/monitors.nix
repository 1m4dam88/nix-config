{ ... }:
{
  wayland.windowManager.hyprland = {
    extraConfig = "
      monitor=DP-1,3440x1440@165,1920x427,1
      monitor=DP-2,1920x1080@75,5360x160,1
      monitor=DP-2,transform,1
      monitor=DP-3,1920x1080@144,0x580,1
      monitor=eDP-1,3840x2160@60,auto,1.5,bitdepth,10
      monitor=LVDS-1,1920x1080@60,auto,1
    ";
 };
}
