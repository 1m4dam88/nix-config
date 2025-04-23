{
  sops = {
    defaultSopsFile = ./../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age = {
      keyFile = "/home/ye/.config/sops/age/keys.txt"; # Path to your private key
      # Or use SSH key: sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      generateKey = false; # Set to true to auto-generate a key (not recommended for production)
    };
    secrets = {
      "my_secret" = { # Maps to the key in secrets.yaml
        path = "/run/secrets/my_secret"; # Where the decrypted secret will be stored
        mode = "0400"; # File permissions
        owner = "root";
        group = "root";
      };
      "wifi_psk" = {};
    };
  };

  # Example: Use a secret for WiFi
}
