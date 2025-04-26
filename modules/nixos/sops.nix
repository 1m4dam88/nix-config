{
  sops = {
    defaultSopsFile = ./../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age = {
      keyFile = "/keys.txt";
    };
    secrets = {
      user_password = {};
      root_password = {};
      github_token = {};
      ssh_key = {};
    };
  };
}
