{
  description = "Nixos config flake";

  inputs = {

    # Core system inputs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";


    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix.url = "github:Mic92/sops-nix";


    # Hyprland stuff
    hyprland.url = "github:hyprwm/Hyprland";

    hyprpicker.url = "github:hyprwm/hyprpicker";


    hypr-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  
    split-monitor-workspaces = {
      url = "github:Duckonaut/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland";
    };

    # Applications

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    nixcord.url = "github:kaylorben/nixcord";

    nix-gaming.url = "github:fufexan/nix-gaming";

    yazi-plugins = {
      url = "github:yazi-rs/plugins";
      flake = false;
    };

    nvchad4nix = {
      url = "github:nix-community/nix4nvchad";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Theming
    stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, sops-nix, disko, nur, home-manager, nixos-hardware, nvchad4nix, ... }@inputs:
    let
      username = "ye";
      system = "x86_64-linux";
      lib = nixpkgs.lib;

      commonOverlays = [
        (final: prev: {
          nvchad = inputs.nvchad4nix.packages."${final.system}".nvchad;
        })
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
            # disko
            disko.nixosModules.disko
            # sops
            sops-nix.nixosModules.sops
            # Hardware-specific modules
          ] ++ hardwareModules ++ extraModules;
        };

    hardwareProfiles = {
        thinkpad = {
          w520 = [ inputs.nixos-hardware.nixosModules.lenovo-thinkpad-w520 ];
          t480 = [ inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480 ];
          x230 = [ inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x230 ];
          x61 = [];
        };
        amd = {
          desktop = [
            inputs.nixos-hardware.nixosModules.common-cpu-amd
            inputs.nixos-hardware.nixosModules.common-cpu-amd-zenpower
            inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
            inputs.nixos-hardware.nixosModules.common-gpu-amd
          ];
        };
        intel = {
          m93p = [
            inputs.nixos-hardware.nixosModules.cpu-intel-haswell
            inputs.nixos-hardware.nixosModules.gpu-intel-haswell
          ];
          z270 = [
            inputs.nixos-hardware.nixosModules.common-cpu-intel
            inputs.nixos-hardware.nixosModules.common-gpu-intel-kaby-lake
          ];
          server = [
            inputs.nixos-hardware.nixosModules.common-cpu-intel
            inputs.nixos-hardware.nixosModules.common-gpu-intel
          ];
        };
      };

    in {
      nixosConfigurations = {
        # ThinkPads
        heavy = mkSystem {
          hostname = "heavy";
          hostDir = ./hosts/heavy;
          hardwareModules = hardwareProfiles.thinkpad.w520;
        };

        wheatley = mkSystem {
          hostname = "wheatley";
          hostDir = ./hosts/wheatley;
          hardwareModules = hardwareProfiles.thinkpad.t480;
        };

        mesa = mkSystem {
          hostname = "mesa";
          hostDir = ./hosts/mesa;
          hardwareModules = hardwareProfiles.thinkpad.x230;
        };

        # Desktop systems
        atlas = mkSystem {
          hostname = "atlas";
          hostDir = ./hosts/atlas;
          hardwareModules = hardwareProfiles.amd.desktop;
        };

        glados = mkSystem {
          hostname = "glados";
          hostDir = ./hosts/glados;
          hardwareModules = hardwareProfiles.intel.server;
        };

        # Intel systems
        chell = mkSystem {
          hostname = "chell";
          hostDir = ./hosts/chell;
          hardwareModules = hardwareProfiles.intel.m93p;
        };

        alyx = mkSystem {
          hostname = "alyx";
          hostDir = ./hosts/alyx;
          hardwareModules = hardwareProfiles.thinkpad.x61;
        };

        aperture = mkSystem {
          hostname = "aperture";
          hostDir = ./hosts/aperture;
          hardwareModules = hardwareProfiles.intel.z270;
        };

        proxvm = mkSystem {
          hostname = "proxvm";
          hostDir = ./hosts/proxvm;
        };
        r730nixos = mkSystem {
          hostname = "r730nixos";
          hostDir = ./hosts/r730nixos;
        };
      };

      homeModules.default = ./modules/home;
      homeModules.minimal = [ 
        ./modules/home/cli
        ./modules/home/light        
      ];
    };
  }

