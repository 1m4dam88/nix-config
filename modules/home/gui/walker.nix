{ config, inputs, pkgs, host, ... }:
{
  home.packages = with pkgs; [ walker ];
}
