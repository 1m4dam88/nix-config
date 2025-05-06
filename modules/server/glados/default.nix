{ config, ... }:
{
  imports = [
    ./mergerfs.nix
    ./tjd.lol.nix
    ./services
  ];
}
