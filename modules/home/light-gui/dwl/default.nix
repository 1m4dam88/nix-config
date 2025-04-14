{ pkgs, ... }:
{
  home.packages = [
    pkgs.somebar
    pkgs.someblocks
    pkgs.wbg
    (pkgs.dwl.override {
      conf = ./config.h
    })
  ];
}
