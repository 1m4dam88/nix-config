{ config, inputs, ... }:
{
  sops = {
    defaultSopsFile = ./../../../secrets/secrets.yaml;
    age.keyFile = "/home/ye/.config/sops/age/keys.txt";
    secrets = {
      "private_keys/ye" = {
        path = "/home/ye/.ssh/id_ed25519";
      };
      "git_token" = {
        mode = "0400"; # Restrict permissions
      };
    };
  };
}
