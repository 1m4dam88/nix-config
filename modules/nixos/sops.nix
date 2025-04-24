{
  sops = {
    defaultSopsFile = ./../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age = {
      keyFile = "~/.config/sops/age/keys.txt"; # Path to your private key
      # Or use SSH key: sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      generateKey = false; # Set to true to auto-generate a key (not recommended for production)
    };
    secrets = {
      "wifi_psk" = {};
    };
  };

  # Example: Use a secret for WiFi
}
