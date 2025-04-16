{ inputs, username, host, ...}: {
  imports = [
    ./blender.nix
    ./browser.nix
    ./cura.nix
    ./discord
    ./foot.nix
    ./fuzzel.nix
    ./gaming.nix
    ./hyprland
    ./hyprpanel.nix
    ./jellyfin.nix
    ./kdeconnect.nix
    ./kicad.nix
    ./krita.nix
    ./mpv.nix
    ./obs.nix
    ./prism.nix
    ./qbittorrent.nix
    ./zathura.nix
  ];
}
