{ config, pkgs, lib, ... }:

let
  hostname = config.networking.hostName;
  commonSecrets = {
    email = {};
    user_password = {};
    root_password = {};
    github_token = {};
    ssh_key = {};
  };

  homelabSecrets = lib.mkIf (hostname == "glados") {
    db-password = {
      format = "yaml";
      sopsFile = ./../../secrets/homelab.yaml;
    };
    paperless_password = {
      format = "yaml";
      sopsFile = ./../../secrets/homelab.yaml;
    };
    deluge = {
      format = "yaml";
      sopsFile = ./../../secrets/homelab.yaml;
      mode = "0775";
      owner = config.users.users.share.name;
      group = config.users.users.share.group;
    };
    tjd-api-key = {
      format = "yaml";
      sopsFile = ./../../secrets/homelab.yaml;
      mode = "0775";
      owner = config.users.users.share.name;
      group = config.users.users.share.group;
    };
    imadam-email = {
      format = "yaml";
      sopsFile = ./../../secrets/homelab.yaml;
      mode = "0775";
      owner = config.users.users.share.name;
      group = config.users.users.share.group;
    };
  };

  cloudflareSecrets = {
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
in
{
  sops = {
    defaultSopsFile = ./../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/keys.txt";
    secrets = commonSecrets // homelabSecrets // cloudflareSecrets;
  };
}
