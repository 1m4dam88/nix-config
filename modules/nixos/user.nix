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
    inputs.stylix.nixosModules.stylix
  ];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs username host; };
    users.${username} = {
      imports = if builtins.getEnv "HOSTNAME" == "x61" then [
          ./../home/light-gui
          ./../home/cli
        ] else [
        ./../home
        inputs.self.outputs.homeManagerModules.default
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
