{ ... }:
{
  wayland.windowManager.hyprland = {
     settings = {
       exec-once = [
          "hyprpanel"
          "udiskie"
          "swww-daemon &"

          "wl-paste --type text --watch cliphist store"
          "wl-paste --type image--watch cliphist store"

          "gnome-keyring-daemon --start --components=secrets"
          "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
          "hypridle"
          "dbus-update-activation-environment --all"
          "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
          "/usr/bin/kdeconnectd"
          "hyprpm-reload"

          "[workspace 1 silent] zen-browser"
          "[workspace 2 silent] steam"
          "[workspace 3 silent] vesktop"
       ];
     };
  };
}
