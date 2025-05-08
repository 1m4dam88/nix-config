{ config, pkgs, lib, ... }:
{
  services = {
    homepage-dashboard = {
      enable = true;
      widgets = [
        {
          resources = {
            cpu = true;
            memory = true;
            disk = "${rootDir}";
            cputemp = true;
            uptime = true;
          };
        }
        {
          datetime = {
            text_size: xl;
            format = {
              timeStyle = long;
              dateStyle = long;
            };
          };
        }
        {
          logo = {
            icon = sh-nixos.svg;
          };
        }
      ];
    };
  };
}
