{
  inputs,
  nixpkgs,
  self,
  username,
  host,
  ...
}:
{
  imports = [
	./bootloader.nix
	./hardware.nix
	./media.nix
	./networking.nix
  ./lact
  ./mount.nix
  ./rgb.nix
  ./nh.nix
	./program.nix
  ./gaming.nix
	./services.nix
	./system.nix
	./virtualization.nix
	./wayland.nix
  ./thunar.nix
	./user.nix
  ./stylix.nix
  ./fonts.nix
   ];
}
