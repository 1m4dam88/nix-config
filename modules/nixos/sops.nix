{
  sops = {
    defaultSopsFile = ./../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age = {
      keyFile = "/home/ye/.config/sops/age/keys.txt"; # Path to your private key
      sshKeyPaths = [ "/home/ye/.ssh/id_ed25519" ];
      generateKey = false; # Set to true to auto-generate a key (not recommended for production)
    };
    secrets = {
      "ye_password".neededForUsers = true;
      "ye_password" = {};
      "root_password".neededForUsers = true;
      "root_password" = {};
      wifi_psk = {
        sopsFile = ./../../secrets/secrets.yaml;
      };
    };
  };

  # Example: Use a secret for WiFi
}
