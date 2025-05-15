{ config, pkgs, lib, ... }:
let
  hostname = config.networking.hostName; 
in 
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
      db-password = lib.mkIf (hostname == "glados") {
        format = "yaml";
        sopsFile = ./../../secrets/homelab.yaml;
      };
      paperless_password = lib.mkIf (hostname == "glados") {
        format = "yaml";
        sopsFile = ./../../secrets/homelab.yaml;
      };
      deluge = lib.mkIf (hostname == "glados") {
        format = "yaml";
        sopsFile = ./../../secrets/homelab.yaml;
        mode = "0775";
        owner = config.users.users.share.name;
        group = config.users.users.share.group;
      };
      tjd-api-key = lib.mkIf (hostname == "glados") {
        format = "yaml";
        sopsFile = ./../../secrets/homelab.yaml;
        mode = "0775";
        owner = config.users.users.share.name;
        group = config.users.users.share.group;
      };
      imadam-email = lib.mkIf (hostname == "glados") {
        format = "yaml";
        sopsFile = ./../../secrets/homelab.yaml;
        mode = "0775";
        owner = config.users.users.share.name;
        group = config.users.users.share.group;
      };
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
