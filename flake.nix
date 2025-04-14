{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
    { nixpkgs, catppuccin, home-manager, self, split-monitor-workspaces, stylix, ... }@inputs:
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
	          ];
         specialArgs = {
           host = "t480";
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
	          ];
         specialArgs = {
           host = "desktop";
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
	          ];
         specialArgs = {
           host = "m93p";
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
	            home-manager.nixosModules.home-manager
	          ];
         specialArgs = {
           host = "x61";
      	   inherit self inputs username;
         };
        };
      };
      homeManagerModules.default = ./modules/home;
    };
}

