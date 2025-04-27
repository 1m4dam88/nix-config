{ pkgs, ... }:
{
  home.packages = [
    pkgs.somebar
    pkgs.tofi
    pkgs.wbg
    (pkgs.dwl.override {
      conf = ./config.h;
    })
  ];
}
