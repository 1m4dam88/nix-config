{ pkgs, config, ... }:
{
  programs.fish.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  environment.systemPackages = with pkgs; [
    p7zip
    unzip
    unrar
  ];
}
