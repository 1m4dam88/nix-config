{ pkgs, host, ... }:
{
  networking = {
    firewall = {
      enable = false;
    };  
    hostName = "${host}";
    networkmanager.enable = true;
  };

  environment.systemPackages = with pkgs; [ networkmanagerapplet ];
}
