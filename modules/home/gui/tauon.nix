{ pkgs, ... }:
{
  home.packages = with pkgs; [
    tauon
  ];
}
