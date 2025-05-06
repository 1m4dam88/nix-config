{
  sops = {
    defaultSopsFile = ./../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age = {
      keyFile = "/keys.txt";
    };
    secrets = {
      email = {};
      user_password = {};
      root_password = {};
      github_token = {};
      ssh_key = {};
      fagwar-api-key = {
        format = "yaml";
        sopsFile = ./../../secrets/cloudflare.yaml;
      };
      adam-aperture-tunnel-id = {
        format = "yaml";
        sopsFile = ./../../secrets/cloudflare.yaml;
      };
      adam-aperture-tunnel = {
        format = "yaml";
        sopsFile = ./../../secrets/cloudflare.yaml;
      };
      fagwar-email = {
        format = "yaml";
        sopsFile = ./../../secrets/cloudflare.yaml;
      };
    };
  };
}
