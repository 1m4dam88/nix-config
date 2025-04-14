{ pkgs, host, ... }:
{
  programs.foot = {
   enable = true;
   settings = {
     main = {
      font = "Caskaydia Cove Nerd Font:size=12";
      pad = "10x10";
     };
   };
 };
}
