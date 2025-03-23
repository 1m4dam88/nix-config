{ inputs, username, host, ...}: {
  imports = [
    ./fastfetch.nix
    ./hyprland
    ./hyprpanel.nix
    ./fuzzel.nix
    ./discord
    ./browser.nix
    ./git.nix
    ./fish.nix
    ./foot.nix
    ./nvim.nix
  ];
}
