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
  };

  outputs = 
    { nixpkgs, self, ... }@inputs:
    let
      username = "ye";
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        w520 = nixpkgs.lib.nixosSystem {
         inherit system;
         modules = [ ./hosts/w520 ];
         specialArgs = {
           host = "w520";
      	   inherit self inputs username;
         };
        };
       };

      };
}
