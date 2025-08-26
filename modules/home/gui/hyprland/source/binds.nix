{ ... }:
{
  wayland.windowManager.hyprland = {
     settings = {
       bindle = [
                ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
                ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
                ", XF86MonBrightnessUp, exec, brightnessctl set '+5%'"
                ", XF86MonBrightnessDown, exec, brightnessctl set '5%-'"
       ];
       bindl = [
                ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
                ", XF86AudioNext, exec, playerctl next"
                ", XF86AudioPrev, exec, playerctl previous"
                ", XF86AudioPlay, exec, playerctl play-pause"
                ", XF86AudioPause, exec, playerctl previous"
       ];
       bindm = [
                "$mainMod, mouse:272, movewindow"
                "$mainMod, mouse:273, resizewindow"
       ];
       bind = [
                "$mainMod, Q, killactive"
                "$mainMod, F, fullscreen"
                "$mainMod shift, Space, togglefloating"
                "$mainMod, J, movefocus, l"
                "$mainMod, K, movefocus, r"
                "$mainMod shift, h, movewindow, l"
                "$mainMod shift, j, movewindow, d"
                "$mainMod shift, k, movewindow, u"
                "$mainMod shift, l, movewindow, r"
                "$mainMod, h, resizeactive, -100 0"
                "$mainMod, l, resizeactive, 100 0"
                "$mainMod, Space, swapsplit"
                "$mainMod, s, pin"
                "$mainMod, a, exec, killall -SIGUSR1 waybar"
                
                "$mainMod, W, exec, zen"
                "$mainMod, E, exec, bemoji -t"
                "$mainMod, R, exec, foot -e yazi"
                "$mainMod shift, R, exec, thunar"
                "$mainMod, Y, exec, discord"
                "$mainMod, U, exec, obs"
                "$mainMod, O, exec, prismlauncher"
                "$mainMod, D, exec, walker"
                "$mainMod, backspace, exec, hyprlock"
                "$mainMod shift, C, exec, hyprpicker -a"
                "$mainMod, V, exec, cliphist list |  fuzzel --match-mode fzf --dmenu | cliphist decode | wl-copy"
                "$mainMod shift, V, exec, foot -e cava"
                "$mainMod, N, exec, steam"
                "$mainMod, M, exec, foot -e ncmpcpp"
                "$mainMod, Return, exec, foot"
                "$mainMod shift, Return, exec, foot"
                ", Print, exec, grimblast --freeze copysave area ~/Pictures/Screenshots/$(date '+%Y-%m-%d %H:%M:%S').png"
                "Ctrl, Print, exec, grimblast --freeze save area - |  swappy -f -"
                "SHIFT, Print, exec, grimblast copysave output ~/Pictures/Screenshots/$(date '+%Y-%m-%d %H:%M:%S').png'"
                "Ctrl SHIFT, Print, exec, grimblast --freeze save output - |  swappy -f -"
                "$mainMod, Print, exec, grimblast --freeze copysave active ~/Pictures/Screenshots/$(date '+%Y-%m-%d %H:%M:%S').png"
                "$mainMod Ctrl, Print, exec, grimblast --freeze save active - |  swappy -f -"
                
                
                "$mainMod, 1, split-workspace, 1"
                "$mainMod, 2, split-workspace, 2"
                "$mainMod, 3, split-workspace, 3"
                "$mainMod, 4, split-workspace, 4"
                "$mainMod, 5, split-workspace, 5"
                "$mainMod, 6, split-workspace, 6"
                "$mainMod, 7, split-workspace, 7"
                "$mainMod, 8, split-workspace, 8"
                "$mainMod, 9, split-workspace, 9"
                "$mainMod, 0, split-workspace, 10"
                
                "$mainMod SHIFT, 1, split-movetoworkspace, 1"
                "$mainMod SHIFT, 2, split-movetoworkspace, 2"
                "$mainMod SHIFT, 3, split-movetoworkspace, 3"
                "$mainMod SHIFT, 4, split-movetoworkspace, 4"
                "$mainMod SHIFT, 5, split-movetoworkspace, 5"
                "$mainMod SHIFT, 6, split-movetoworkspace, 6"
                "$mainMod SHIFT, 7, split-movetoworkspace, 7"
                "$mainMod SHIFT, 8, split-movetoworkspace, 8"
                "$mainMod SHIFT, 9, split-movetoworkspace, 9"
                "$mainMod SHIFT, 0, split-movetoworkspace, 10"
       ];
     };
  };
}
