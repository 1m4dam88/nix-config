{ pkgs, inputs, ... }:
{ 
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];
  programs.nixcord = {
    enable = true;
    config = {
      themeLinks = [ 
        https://github.com/refact0r/system24/raw/refs/heads/main/theme/flavors/catppuccin-mocha.theme.css 
      ];
      plugins = {
      };
  };
 };
}
