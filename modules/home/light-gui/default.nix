{ inputs, username, host, ...}: {
  imports = [
    ./dwl
    ./foot.nix
    ./dunst.nix
    ./mpv.nix
    ./zathura.nix
  ];
}
