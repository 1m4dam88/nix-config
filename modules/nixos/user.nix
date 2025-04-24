{ pkgs, inputs, username, host, ... }:

let
  # Define Home-Manager imports based on host
  homeImports = {
    "x61" = [
      ./../home/light-gui
      ./../home/cli
      inputs.self.homeModules.default  # Changed from outputs.homeManagerModules
    ];

    "z270" = [
      ./../home/cli
      inputs.self.homeModules.default  # Changed from outputs.homeManagerModules
    ];

    default = [
      ./../home
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

  # User configuration
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [ 
      "networkmanager" "wheel"
    ];
    shell = pkgs.fish;
  };

  # Nix settings
  nix.settings.allowed-users = [ username ];
}
