{ lib, config, pkgs, host, ... }:
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

  sops.secrets.wifi_ssid = {
    sopsFile = ./../../secrets/secrets.yaml;
    mode = "0400";
  };

  sops.secrets.wifi_psk = {
    sopsFile = ./../../secrets/secrets.yaml;
    mode = "0400";
  };

  # Create a NetworkManager connection file for WiFi
  environment.etc."NetworkManager/system-connections/MyWiFi.nmconnection" = {
    text = ''
      [connection]
      id=MyWiFi
      uuid=${builtins.replaceStrings ["-"] [""] (builtins.hashString "sha256" "MyWiFi")}
      type=wifi
      [wifi]
      ssid=${config.sops.secrets.wifi_ssid.path}
      mode=infrastructure
      [wifi-security]
      key-mgmt=wpa-psk
      psk=${config.sops.secrets.wifi_psk.path}
      [ipv4]
      method=auto
      [ipv6]
      method=auto
    '';
    mode = "0600";
  };

}
