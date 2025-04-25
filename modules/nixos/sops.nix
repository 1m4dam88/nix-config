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
      user_password = {
        sopsFile = ./../../secrets/secrets.yaml;
        neededForUsers = true;
      };
      root_password = {
        sopsFile = ./../../secrets/secrets.yaml;
        neededForUsers = true;
      };
      "wifi_psk" = {
        sopsFile = ./../../secrets/secrets.yaml;
      };
    };
  };

  # Example: Use a secret for WiFi
}
