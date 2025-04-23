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
    ./hugo.nix
    ./nvim.nix
    ./profanity.nix
    ./ripgrep.nix
    ./sops.nix
    ./yazi.nix
    ./yt.nix
    ./zoxide.nix
  ];
}
