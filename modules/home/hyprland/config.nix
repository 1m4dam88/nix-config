{ ... }:
{
  wayland.windowManager.hyprland = {
     settings = {
       input = {
         kb_layout = "gb";
	 repeat_delay = 300;
	 repeat_rate = 50;
       };

       general = {
        "$mainMod" = "SUPER";
        gaps_in = 0;
	gaps_out = 0;
       };

       bind = [
        "$mainMod, Q, killactive"
	"$mainMod, F, fullscreen"
	"$mainMod shift, Space, togglefloating"
	"$mainMod, J, movefocus, l"
	"$mainMod, K, movefocus, r"
	"$mainMod, J, movefocus, l"
	"$mainMod, J, movefocus, l"
	"$mainMod shift, h, movewindow, l" 
	"$mainMod shift, j, movewindow, d" 
	"$mainMod shift, k, movewindow, u" 
	"$mainMod shift, l, movewindow, r" 
	"$mainMod, h, resizeactive, -100 0"
	"$mainMod, l, resizeactive, 101 0"
	"$mainMod, Space, swapsplit"
	"$mainMod, s, pin"
	"$mainMod, mouse:272, movewindow"
	"$mainMod, mouse:273, resizewindow"
       	"$mainMod, Return, exec, foot"
       	"$mainMod, W, exec, zen"
       	"$mainMod, D, exec, fuzzel"
       ];
      };

    extraConfig = "
     monitor=LVDS-1,1920x1080@60,auto,1
    ";
 };
}
