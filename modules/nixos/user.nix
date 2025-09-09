{ config, pkgs, inputs, username, host, ... }:

let
  # Define Home-Manager imports based on host
  homeImports = {
    "alyx" = [
      ./../home/cli
      ./../home/light
    ];

    "aperture" = [
      ./../home/cli
    ];

    "testvm" = [
      ./../home/cli
    ];

    "glados" = [
      ./../home/cli
    ];

    "proxvm" = [
      ./../home/cli
    ];

    default = [
      inputs.self.homeModules.default  # Changed from outputs.homeManagerModules
    ];
  };

  # Select imports for the current host, falling back to default
  selectedHomeImports = homeImports.${host} or homeImports.default;

in {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix
    inputs.sops-nix.nixosModules.sops

    {
      # Share sops-nix with Home-Manager
      home-manager.sharedModules = [ inputs.sops-nix.homeManagerModules.sops ];
    }
  ];

  # Home-Manager configuration
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    extraSpecialArgs = { 
      inherit inputs username host;
      inherit (inputs) self;  # Pass self (your flake) through
    };

    users.${username} = {
      imports = selectedHomeImports;

      home = {
        username = username;
        homeDirectory = "/home/${username}";
        stateVersion = "24.11";
      };

      programs.home-manager = {
        enable = true;
      };
    };
  };
  sops.secrets.user_password.neededForUsers = true;
  sops.secrets.root_password.neededForUsers = true;
  users.mutableUsers = false;
  # User configuration
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    shell = pkgs.fish;
    hashedPasswordFile = config.sops.secrets.user_password.path;
    extraGroups = [ 
      "networkmanager" "wheel" "adbusers" "kvm" "input"
    ];
    openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINWKYIrwL21t4Q/hbGUmLuVFOb1b77OHjbL0vqSo13kc ye@atlas"
    ];
  };

  users.users.root = {
    hashedPasswordFile = config.sops.secrets.root_password.path;
    openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINWKYIrwL21t4Q/hbGUmLuVFOb1b77OHjbL0vqSo13kc ye@atlas"
    ];
  };
  

  # Nix settings
}
