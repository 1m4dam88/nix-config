{ inputs, pkgs, ... }:
let
  hyprland-pkgs =
    inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  hardware = {
    opengl = {
      enable = true;
      driSupport32Bit = true;
    };
    graphics = {
      enable = true;
      package = hyprland-pkgs.mesa;
      extraPackages = with pkgs; [
        intel-vaapi-driver
      ];
     }; 
    };
    hardware.enableRedistributableFirmware = true;
}
