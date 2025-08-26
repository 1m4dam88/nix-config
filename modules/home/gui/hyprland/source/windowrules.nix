{ ... }:
{
  wayland.windowManager.hyprland = {
    settings = {
      windowrule = [
        "float,title:^(Open File)(.*)$"
        "float,title:^(Select a File)(.*)$"
        "float,title:^(Choose wallpaper)(.*)$"
        "float,title:^(Open Folder)(.*)$"
        "float,title:^(Save As)(.*)$"
        "float,title:^(Library)(.*)$"
        "float,title:^(File Upload)(.*)$"
       
        "float,class:^(nwg-look)$"
        
        # Pavucontrol floating
        "float,class:(.*org.pulseaudio.pavucontrol.*)"
        "size 700 600,class:(.*org.pulseaudio.pavucontrol.*)"
        "center,class:(.*org.pulseaudio.pavucontrol.*)"
        "pin,class:(.*org.pulseaudio.pavucontrol.*)"
        
        # Picture in Picture Floating
        "keepaspectratio, title:^(Picture(-| )in(-| )[Pp]icture)$"
        "move 73% 72%,title:^(Picture(-| )in(-| )[Pp]icture)$ "
        "size 25%, title:^(Picture(-| )in(-| )[Pp]icture)$"
        "float, title:^(Picture(-| )in(-| )[Pp]icture)$"
        "pin, title:^(Picture(-| )in(-| )[Pp]icture)$"
        
        # Steam
        "float, class:^([Ss]team)$, title:^((?![Ss]team).*)$"
        "workspace 3 silent, class:^([Ss]team)$, title:^([Ss]team)$"
        "tile, class:^([Ss]team)$, title:^([Ss]team)$"
        "fullscreen,class:^steam_app\d+$"
        "monitor 1,class:^steam_app_\d+$"
        "workspace 3,class:^steam_app_\d+$"
        
        # MPV Floating
        "float, class:(mpv)"
      ];
    };
  };
}
