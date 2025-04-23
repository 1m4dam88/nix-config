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

  outputs = 
    { sops-nix, disko, nur, nixpkgs, catppuccin, home-manager, self, split-monitor-workspaces, stylix, ... }@inputs:
    let
      lib = nixpkgs.lib;
      username = "ye";
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
      extraSpecialArgs = { inherit system; inherit inputs; };  # <- passing inputs to the attribute set for home-manager
      specialArgs = { inherit system; inherit inputs; };       # <- passing inputs to the attribute set for NixOS (optional)
    in
    {
      nixosConfigurations = {
        w520 = nixpkgs.lib.nixosSystem {
         inherit system;
               modules = [ 
      	        {
            	   nixpkgs = {
            	    overlays = [
            	     (final: prev: {
            	     nvchad = inputs.nvchad4nix.packages."${pkgs.system}".nvchad;
            	     })
            	     inputs.hyprpanel.overlay
            	   ];
            	  };
            	}
	            ./hosts/w520 
	            home-manager.nixosModules.home-manager
              inputs.nixos-hardware.nixosModules.lenovo-thinkpad-w520
              nur.modules.nixos.default
	          ];
         specialArgs = {
           host = "w520";
      	   inherit self inputs username;
         };
        };
        t480 = nixpkgs.lib.nixosSystem {
         inherit system;
               modules = [ 
      	        {
            	   nixpkgs = {
            	    overlays = [
            	     (final: prev: {
            	     nvchad = inputs.nvchad4nix.packages."${pkgs.system}".nvchad;
            	     })
            	     inputs.hyprpanel.overlay
            	   ];
            	  };
            	}
	            ./hosts/t480
	            home-manager.nixosModules.home-manager
              inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480
              nur.modules.nixos.default
              sops-nix.nixosModules.sops
	          ];
         specialArgs = {
           host = "wheatley";
      	   inherit self inputs username;
         };
        };
        x230 = nixpkgs.lib.nixosSystem {
         inherit system;
               modules = [ 
      	        {
            	   nixpkgs = {
            	    overlays = [
            	     (final: prev: {
            	     nvchad = inputs.nvchad4nix.packages."${pkgs.system}".nvchad;
            	     })
            	     inputs.hyprpanel.overlay
            	   ];
            	  };
            	}
	            ./hosts/x230
	            home-manager.nixosModules.home-manager
              inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x230
              nur.modules.nixos.default
              sops-nix.nixosModules.sops
	          ];
         specialArgs = {
           host = "mesa";
      	   inherit self inputs username;
         };
        };
        desktop = nixpkgs.lib.nixosSystem {
         inherit system;
               modules = [ 
      	        {
            	   nixpkgs = {
            	    overlays = [
            	     (final: prev: {
            	     nvchad = inputs.nvchad4nix.packages."${pkgs.system}".nvchad;
            	     })
            	     inputs.hyprpanel.overlay
            	   ];
            	  };
            	}
	            ./hosts/desktop
	            home-manager.nixosModules.home-manager
              inputs.nixos-hardware.nixosModules.common-cpu-amd
              inputs.nixos-hardware.nixosModules.common-cpu-amd-zenpower
              inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
 	            inputs.nixos-hardware.nixosModules.common-gpu-amd
              nur.modules.nixos.default
              sops-nix.nixosModules.sops
	          ];
         specialArgs = {
           host = "atlas";
      	   inherit self inputs username;
         };
        };
        server = nixpkgs.lib.nixosSystem {
         inherit system;
               modules = [ 
      	        {
            	   nixpkgs = {
            	    overlays = [
            	     (final: prev: {
            	     nvchad = inputs.nvchad4nix.packages."${pkgs.system}".nvchad;
            	     })
            	     inputs.hyprpanel.overlay
            	   ];
            	  };
            	}
	            ./hosts/server
	            home-manager.nixosModules.home-manager
              inputs.nixos-hardware.nixosModules.common-cpu-amd
              inputs.nixos-hardware.nixosModules.common-cpu-amd-zenpower
              inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
 	            inputs.nixos-hardware.nixosModules.common-gpu-amd
              nur.modules.nixos.default
              sops-nix.nixosModules.sops
	          ];
         specialArgs = {
           host = "glados";
      	   inherit self inputs username;
         };
        };
        m93p = nixpkgs.lib.nixosSystem {
         inherit system;
               modules = [ 
      	        {
            	   nixpkgs = {
            	    overlays = [
            	     (final: prev: {
            	     nvchad = inputs.nvchad4nix.packages."${pkgs.system}".nvchad;
            	     })
            	     inputs.hyprpanel.overlay
            	   ];
            	  };
            	}
	            ./hosts/m93p
	            home-manager.nixosModules.home-manager
              inputs.nixos-hardware.nixosModules.cpu-intel-haswell
              inputs.nixos-hardware.nixosModules.gpu-intel-haswell
              nur.modules.nixos.default
              sops-nix.nixosModules.sops
	          ];
         specialArgs = {
           host = "chell";
      	   inherit self inputs username;
         };
        };
        x61 = nixpkgs.lib.nixosSystem {
         inherit system;
               modules = [ 
      	        {
            	   nixpkgs = {
            	    overlays = [
            	     (final: prev: {
            	     nvchad = inputs.nvchad4nix.packages."${pkgs.system}".nvchad;
            	     })
            	     inputs.hyprpanel.overlay
            	   ];
            	  };
            	}
	            ./hosts/x61
              ./hosts/x61/disko-config.nix
	            home-manager.nixosModules.home-manager
              disko.nixosModules.disko
              nur.modules.nixos.default
              sops-nix.nixosModules.sops
	          ];
         specialArgs = {
           host = "alyx";
      	   inherit self inputs username;
         };
        };
        z270 = nixpkgs.lib.nixosSystem {
         inherit system;
               modules = [ 
      	        {
            	   nixpkgs = {
            	    overlays = [
            	     (final: prev: {
            	     nvchad = inputs.nvchad4nix.packages."${pkgs.system}".nvchad;
            	     })
            	     inputs.hyprpanel.overlay
            	   ];
            	  };
            	}
	            ./hosts/z270
	            home-manager.nixosModules.home-manager
              inputs.nixos-hardware.nixosModules.cpu-intel-kabylake
              inputs.nixos-hardware.nixosModules.gpu-intel-kabylake
              nur.modules.nixos.default
              sops-nix.nixosModules.sops
	          ];
         specialArgs = {
           host = "aperture";
      	   inherit self inputs username;
         };
        };
      };
      homeManagerModules.default = ./modules/home;
    };
}

