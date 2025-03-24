{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    hyprpicker.url = "github:hyprwm/hyprpicker";

    nix-gaming.url = "github:fufexan/nix-gaming";

    hyprland.url = "github:hyprwm/Hyprland";

    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    nixcord.url = "github:kaylorben/nixcord";

    catppuccin.url = "github:catppuccin/nix";

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

    nvchad4nix = {
      url = "github:nix-community/nix4nvchad";
      inputs.nixpkgs.follows = "nixpkgs";
   };
  };

  outputs = 
    { nixpkgs, catppuccin, home-manager, self, ... }@inputs:
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
	 ];
         specialArgs = {
           host = "w520";
      	   inherit self inputs username;
         };
        };
       };
      };
}
