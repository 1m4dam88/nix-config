{ config, pkgs, lib, ... }:
{
  services = {
    cloudflared = {
      enable = true;
      tunnels = {
        "glados" = {
          credentialsFile = config.sops.secrets.
        }
      }
    }
  }
}
