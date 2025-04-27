{ pkgs, config, ...}: {
  home.packages = [
    pkgs.somebar
    pkgs.wbg
  ];
  imports = [
    ./dwl
    ./browser.nix
    ./foot.nix
    ./dunst.nix
    ./mpv.nix
    ./zathura.nix
    ./tofi.nix
  ];
}
