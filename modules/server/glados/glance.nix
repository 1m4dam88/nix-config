{ config, pkgs, lib, ... }:
{
  services = {
    glance = {
      enable = true;
      settings = {
      };
    };
  };
}
