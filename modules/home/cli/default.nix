{ inputs, username, host, ...}: {
  imports = [
    ./bat.nix
    ./btop.nix
    ./cava.nix
    ./eza.nix
    ./fastfetch.nix
    ./fish.nix
    ./fzf.nix
    ./git.nix
    ./nvim.nix
    ./ripgrep.nix
    ./yazi.nix
    ./yt.nix
    ./zoxide.nix
  ];
}
