{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix.url = "github:Mic92/sops-nix";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    hyprpicker.url = "github:hyprwm/hyprpicker";

    nix-gaming.url = "github:fufexan/nix-gaming";

    hyprland.url = "github:hyprwm/Hyprland";

    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    nixcord.url = "github:kaylorben/nixcord";

    catppuccin.url = "github:catppuccin/nix";

    stylix.url = "github:danth/stylix";

    yazi-plugins = {
      url = "github:yazi-rs/plugins";
      flake = false;
    };

    spicetify-nix = {
      url = "github:gerg-l/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hypr-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  
    split-monitor-workspaces = {
      url = "github:Duckonaut/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland";
    };

    nvchad4nix = {
      url = "github:nix-community/nix4nvchad";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, sops-nix, disko, nur, home-manager, nixos-hardware, hyprpanel, nvchad4nix, ... }@inputs:
    let
      username = "ye";
      system = "x86_64-linux";
      lib = nixpkgs.lib;

      commonOverlays = [
        (final: prev: {
          nvchad = inputs.nvchad4nix.packages."${final.system}".nvchad;
        })
        inputs.hyprpanel.overlay
      ];

      mkSystem = { hostname, hostDir, hardwareModules ? [], extraModules ? [] }: 
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs username;
            host = hostname;
          };
          modules = [
            # Common configuration
            {
              nixpkgs = {
                config.allowUnfree = true;
                overlays = commonOverlays;
              };
            }
            # Host-specific configuration
            hostDir
            # Home-Manager integration
            home-manager.nixosModules.home-manager
            # NUR
            nur.modules.nixos.default
            # Sops-nix (except for w520, as in original)
            # Hardware-specific modules
          ] ++ hardwareModules ++ extraModules;
        };

    in {
      nixosConfigurations = {
        w520 = mkSystem {
          hostname = "w520";
          hostDir = ./hosts/w520;
          hardwareModules = [ nixos-hardware.nixosModules.lenovo-thinkpad-w520 ];
        };

        t480 = mkSystem {
          hostname = "wheatley";
          hostDir = ./hosts/t480;
          hardwareModules = [ nixos-hardware.nixosModules.lenovo-thinkpad-t480 ];
        };

        x230 = mkSystem {
          hostname = "mesa";
          hostDir = ./hosts/x230;
          hardwareModules = [ nixos-hardware.nixosModules.lenovo-thinkpad-x230 ];
        };

        desktop = mkSystem {
          hostname = "atlas";
          hostDir = ./hosts/desktop;
          hardwareModules = [
            nixos-hardware.nixosModules.common-cpu-amd
            nixos-hardware.nixosModules.common-cpu-amd-zenpower
            nixos-hardware.nixosModules.common-cpu-amd-pstate
            nixos-hardware.nixosModules.common-gpu-amd
          ];
        };

        server = mkSystem {
          hostname = "glados";
          hostDir = ./hosts/server;
          hardwareModules = [
            nixos-hardware.nixosModules.common-cpu-amd
            nixos-hardware.nixosModules.common-cpu-amd-zenpower
            nixos-hardware.nixosModules.common-cpu-amd-pstate
            nixos-hardware.nixosModules.common-gpu-amd
          ];
        };

        m93p = mkSystem {
          hostname = "chell";
          hostDir = ./hosts/m93p;
          hardwareModules = [
            nixos-hardware.nixosModules.cpu-intel-haswell
            nixos-hardware.nixosModules.gpu-intel-haswell
          ];
        };

        x61 = mkSystem {
          hostname = "alyx";
          hostDir = ./hosts/x61;
          hardwareModules = [];
          extraModules = [
            disko.nixosModules.disko
            ./hosts/x61/disko-config.nix
          ];
        };

        z270 = mkSystem {
          hostname = "aperture";
          hostDir = ./hosts/z270;
          hardwareModules = [
            nixos-hardware.nixosModules.cpu-intel-kabylake
            nixos-hardware.nixosModules.gpu-intel-kabylake
          ];
        };
      };
      homeModules.default = ./modules/home;
    };
}

