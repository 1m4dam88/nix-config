{ config, inputs, pkgs, host, ... }:
{
  imports = [inputs.walker.homeManagerModules.default];
  programs.walker = {
    enable = true;
    runAsService = true;

    config = {
      placeholders."default".input = "Searx";
      providers.prefixes = [
        { provider = "websearch"; prefix = "+";}
      ];
      keybinds.quick_activate = ["F1" "F2" "F3"];
    };
  };
}
