{ pkgs, ... }:
{
  home.packages = [
    pkgs.somebar
    pkgs.wbg
    (pkgs.dwl.override {
      conf = ./config.h;
    })
  ];
}
