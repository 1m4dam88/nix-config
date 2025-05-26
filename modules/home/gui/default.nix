{ inputs, username, host, ...}: {
  imports = [
    ./browser.nix
    ./cura.nix
    ./discord
    ./easyeffects.nix
    ./foot.nix
    ./fuzzel.nix
    ./gaming.nix
    ./hyprland
    ./hyprpanel.nix
    ./imv.nix
    ./jellyfin.nix
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
