{ pkgs, ... }:
{
  home.packages = with pkgs; [ hugo ];
}
