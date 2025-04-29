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

    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

    hypr-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  
    hyprsplit = {
      url = "github:shezdy/hyprsplit";
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
          server = [
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
        };
      };

    in {
      nixosConfigurations = {
        # ThinkPads
        w520 = mkSystem {
          hostname = "w520";
          hostDir = ./hosts/w520;
          hardwareModules = hardwareProfiles.thinkpad.w520;
        };

        t480 = mkSystem {
          hostname = "wheatley";
          hostDir = ./hosts/t480;
          hardwareModules = hardwareProfiles.thinkpad.t480;
        };

        x230 = mkSystem {
          hostname = "mesa";
          hostDir = ./hosts/x230;
          hardwareModules = hardwareProfiles.thinkpad.x230;
        };

        # Desktop systems
        desktop = mkSystem {
          hostname = "atlas";
          hostDir = ./hosts/desktop;
          hardwareModules = hardwareProfiles.amd.desktop;
        };

        server = mkSystem {
          hostname = "glados";
          hostDir = ./hosts/server;
          hardwareModules = hardwareProfiles.amd.server;
        };

        # Intel systems
        m93p = mkSystem {
          hostname = "chell";
          hostDir = ./hosts/m93p;
          hardwareModules = hardwareProfiles.intel.m93p;
        };

        x61 = mkSystem {
          hostname = "alyx";
          hostDir = ./hosts/x61;
          hardwareModules = hardwareProfiles.thinkpad.x61;
          extraModules = [
                  ];
        };

        z270 = mkSystem {
          hostname = "aperture";
          hostDir = ./hosts/z270;
          hardwareModules = hardwareProfiles.intel.z270;
        };

        testvm = mkSystem {
          hostname = "testvm";
          hostDir = ./hosts/testvm;
        };
      };

      homeModules.default = ./modules/home;
      homeModules.minimal = [ 
        ./modules/home/light-gui
        ./modules/home/cli
      ];
    };
  }

