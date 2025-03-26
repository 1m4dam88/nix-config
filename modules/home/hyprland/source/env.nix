{ ... }:
{
  wayland.windowManager.hyprland = {
     settings = {
       env = [
          "HYPRCURSOR_THEME = Bibata Modern Classic"
          "HYPRCUROR_SIZE = 24"
          "XDG_CURRENT_DESKTOP = Hyprland"
          "XDG_SESSION_TYPE = wayland"
          "XDG_SESSION_DESKTOP = Hyprland"
          "GDK_BACKEND = wayland,x11,"
          "QT_QPA_PlATFORM = wayland;xcb"
          "QT_WAYLAND_DISABLE_WINDOWDECORATION = 1"
          "QT_AUTO_SCREEN_SCALE_FACTOR = 1"
       ];
     };
  };
}
