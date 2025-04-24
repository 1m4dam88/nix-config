{ config, inputs, ... }:
{
  sops = {
    defaultSopsFile = ./../../../secrets/secrets.yaml;
    age.keyFile = "/home/ye/.config/sops/age/keys.txt";
    secrets = {
      "git_token" = {
        mode = "0400"; # Restrict permissions
      };
    };
  };
}
