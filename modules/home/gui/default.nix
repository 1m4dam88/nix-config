{ inputs, username, host, ...}: {
  imports = [
    ./3dp.nix
    ./avizo.nix
    ./browser.nix
    ./easyeffects.nix
    ./foot.nix
    ./gaming.nix
    ./hyprland
    ./imv.nix
    #./jellyfin.nix # qtwebengone 5 is marked unsafe so commenting for now
    ./kdeconnect.nix
    ./kicad.nix
    ./krita.nix
    ./mako.nix
    ./mpv.nix
    ./obs.nix
    ./prism.nix
    ./qbittorrent.nix
    ./signal.nix
    ./tauon.nix
    ./vial.nix
    ./walker.nix
    ./waybar.nix
    ./zathura.nix
  ];
}
