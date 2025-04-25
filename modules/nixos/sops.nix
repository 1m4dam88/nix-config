{
  sops = {
    defaultSopsFile = ./../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age = {
      keyFile = "/home/ye/.config/sops/age/keys.txt";
    };
    secrets = {
      user_password = {};
      root_password = {};
      github_token = {};
      ssh_key = {};
    };
  };
}
