{ inputs, username, host, ...}: {
  imports = [
    ./discord
    ./hyprland
    ./browser.nix
    ./cura.nix
    ./foot.nix
    ./fuzzel.nix
    ./gaming.nix
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
