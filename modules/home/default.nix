{ inputs, username, host, ...}: {
  imports = [
    ./bat.nix
    ./btop.nix
    ./browser.nix
    ./catppuccin.nix
    ./cava.nix
    ./discord
    ./fastfetch.nix
    ./fish.nix
    ./fuzzel.nix
    ./foot.nix
    ./fzf.nix
    ./git.nix
    ./hyprland
    ./hyprpanel.nix
    ./nvim.nix
    ./ripgrep.nix
    ./yazi.nix
  ];
}
