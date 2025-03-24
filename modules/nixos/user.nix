{
  pkgs,
  inputs,
  outputs,
  username,
  host,
  ...
}:
{
  imports = [ 
    inputs.home-manager.nixosModules.home-manager 
    inputs.catppuccin.nixosModules.catppuccin
  ];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs username host; };
    users.${username} = {
      imports = [ 
        ./../home 
	inputs.catppuccin.homeManagerModules.catppuccin
      ];
      home.username = "${username}";
      home.homeDirectory = "/home/${username}";
      home.stateVersion = "24.11";
      programs.home-manager.enable = true;
    };
   };

   users.users.${username} = {
     isNormalUser = true;
     description = "${username}";
     extraGroups = [
       "networkmanager"
       "wheel"
     ];
     shell = pkgs.fish;
    };
    nix.settings.allowed-users = [ "${username}" ];
}
