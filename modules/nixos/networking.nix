{ pkgs, host, ... }:
{
  boot.kernelParams = ["ipv6.disable=1"];
  networking = {
    enableIPv6 = false;
    firewall = {
      enable = false;
    };  
    hostName = "${host}";
    networkmanager.enable = true;
  };

  environment.systemPackages = with pkgs; [ networkmanagerapplet ];
}
