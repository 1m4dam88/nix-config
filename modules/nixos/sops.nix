{ config, pkgs, lib, ... }:

let
  inherit (lib) mkIf;
  inherit (config.networking) hostName;
  inherit (config.users.users) share;
  
  # Define secret file paths for better maintainability
  secretPaths = {
    common = ./../../secrets/secrets.yaml;
    homelab = ./../../secrets/homelab.yaml;
    cloudflare = ./../../secrets/cloudflare.yaml;
  };

  # Common configuration for YAML secrets
  yamlSecret = sopsFile: {
    format = "yaml";
    inherit sopsFile;
  };

  # Helper for homelab secrets with custom attributes
  homelabSecret = attrs: yamlSecret secretPaths.homelab // attrs;

  # Predicate for homelab hosts
  isHomelabHost = hostName == "glados" || hostName == "proxvm";

  # Common secrets used across all hosts
  commonSecrets = {
    email = {};
    user_password = {};
    root_password = {};
    github_token = {};
    GH_TOKEN_FOR_UPDATES = {};
    ssh_key = {};
  };

  # Homelab-specific secrets (conditionally included)
  homelabSecrets = mkIf isHomelabHost {
    # Database and service passwords
    db_password = yamlSecret secretPaths.homelab;
    paperless_password = yamlSecret secretPaths.homelab;
    
    # Service-specific secrets
    searx-secret = yamlSecret secretPaths.homelab;
    imadam-email = yamlSecret secretPaths.homelab;
    slskd = yamlSecret secretPaths.homelab;
    
    # API tokens and external service credentials
    cloudflare_api_token = yamlSecret secretPaths.homelab;
    
    # File sharing service with custom ownership
    deluge = homelabSecret {
      mode = "0775";
      owner = share.name;
      group = share.group;
    };
  };

  # Combine all secret configurations
  allSecrets = commonSecrets // homelabSecrets // cloudflareSecrets;

in
{
  sops = {
    # Default configuration
    defaultSopsFile = secretPaths.common;
    defaultSopsFormat = "yaml";
    age.keyFile = "/keys.txt";
    
    # Validate that required secrets exist for homelab hosts
    validateSopsFiles = mkIf isHomelabHost true;
    
    # All secret definitions
    secrets = allSecrets;
  };
  
  # Optional: Add assertions for better error handling
  assertions = [
    {
      assertion = !isHomelabHost || (share ? name && share ? group);
      message = "Homelab hosts require 'share' user to be defined with name and group attributes";
    }
  ];
}
#{ config, pkgs, lib, ... }:
#
#let
#  hostname = config.networking.hostName;
#  commonSecrets = {
#    email = {};
#    user_password = {};
#    root_password = {};
#    github_token = {};
#    ssh_key = {};
#  };
#
#  homelabSecrets = lib.mkIf (hostname == "glados" || hostname == "proxvm") {
#    db_password = {
#      format = "yaml";
#      sopsFile = ./../../secrets/homelab.yaml;
#    };
#    searx-secret = {
#      format = "yaml";
#      sopsFile = ./../../secrets/homelab.yaml;
#    };
#    paperless_password = {
#      format = "yaml";
#      sopsFile = ./../../secrets/homelab.yaml;
#    };
#    deluge = {
#      format = "yaml";
#      sopsFile = ./../../secrets/homelab.yaml;
#      mode = "0775";
#      owner = config.users.users.share.name;
#      group = config.users.users.share.group;
#    };
#    cloudflare_api_token = {
#      format = "yaml";
#      sopsFile = ./../../secrets/homelab.yaml;
#    };
#    imadam-email = {
#      format = "yaml";
#      sopsFile = ./../../secrets/homelab.yaml;
#    };
#    slskd = {
#      format = "yaml";
#      sopsFile = ./../../secrets/homelab.yaml;
#    };
#    pyload = {
#      format = "yaml";
#      sopsFile = ./../../secrets/homelab.yaml;
#    };
#  };
#
#  cloudflareSecrets = {
#    fagwar-api-key = {
#      format = "yaml";
#      sopsFile = ./../../secrets/cloudflare.yaml;
#    };
#    adam-aperture-tunnel-id = {
#      format = "yaml";
#      sopsFile = ./../../secrets/cloudflare.yaml;
#    };
#    adam-aperture-tunnel = {
#      format = "yaml";
#      sopsFile = ./../../secrets/cloudflare.yaml;
#    };
#    fagwar-email = {
#      format = "yaml";
#      sopsFile = ./../../secrets/cloudflare.yaml;
#    };
#  };
#in
#{
#  sops = {
#    defaultSopsFile = ./../../secrets/secrets.yaml;
#    defaultSopsFormat = "yaml";
#    age.keyFile = "/keys.txt";
#    secrets = commonSecrets // homelabSecrets // cloudflareSecrets;
#  };
#}
