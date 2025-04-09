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
    ./kdeconnect.nix
    ./kicad.nix
    ./mpv.nix
    ./obs.nix
    ./prism.nix
    ./qbittorrent.nix
    ./zathura.nix
  ];
}
