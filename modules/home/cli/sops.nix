{ config, inputs, ... }:
{
  sops = {
    defaultSopsFile = ./../../../secrets/secrets.yaml;
    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
    secrets = {
      "git_token" = {
        owner = "ye"; # Replace with your user
        group = "users";
        mode = "0400"; # Restrict permissions
      };
    };
  };
}
