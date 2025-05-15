{ inputs, username, host, ...}: {
  imports = [
    ./browser.nix
    ./cura.nix
    ./discord
    ./foot.nix
    ./fuzzel.nix
    ./gaming.nix
    ./hyprland
    ./hyprpanel.nix
    ./jellyfin.nix
    ./imv.nix
    ./kdeconnect.nix
    ./kicad.nix
    ./krita.nix
    ./mpv.nix
    ./obs.nix
    ./prism.nix
    ./qbittorrent.nix
    ./signal.nix
    ./vial.nix
    ./waybar.nix
    ./zathura.nix
  ];
}
