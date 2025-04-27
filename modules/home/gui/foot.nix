{ pkgs, host, ... }:
{
  programs.foot = {
   enable = true;
   settings = {
     main = {
      font = "Caskaydia Cove Nerd Font:size8";
      pad = "0x0";
     };
   };
 };
}
