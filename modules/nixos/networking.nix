{ pkgs, host, ... }:
{
  networking = {
    enableIPv6 = false;
    boot.kernelParams = ["ipv6.disable=1"];
    firewall = {
      enable = false;
    };  
    hostName = "${host}";
    networkmanager.enable = true;
  };

  environment.systemPackages = with pkgs; [ networkmanagerapplet ];
}
