{ pkgs, ... }:
{
  home.packages = [
    (pkgs.dwl.override {
      conf = ./config.h;
    })
  ];
}
