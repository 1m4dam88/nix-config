{ config, pkgs, lib, ... }:
{
  services = {
    searx = {
      enable = true;
      settings = { 
        server = {
          secret_key = "config.sops.secrets.searx-secret.path";
        };
      };
    };
  };
}
