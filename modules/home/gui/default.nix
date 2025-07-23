{ inputs, username, host, ...}: {
  imports = [
    ./3dp.nix
    ./browser.nix
    ./discord
    ./easyeffects.nix
    ./foot.nix
    ./fuzzel.nix
    ./gaming.nix
    ./hyprland
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
    ./tauon.nix
    ./vial.nix
    ./waybar.nix
    ./zathura.nix
  ];
}
