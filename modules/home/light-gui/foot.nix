{ lib, pkgs, host, ... }:
{
  programs.foot = {
   enable = true;
   settings = {
     main = {
      font = lib.mkForce "Terminus (TTF):size=12";
      pad = "0x0";
     };
   };
 };
}
