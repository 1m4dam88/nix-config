{ pkgs, config, ... }:
{
  programs = {
    adb.enable = true;
    fish.enable = true;
    dconf.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
  environment.systemPackages = with pkgs; [
    p7zip
    unzip
    unrar
    unetbootin
    sops
    ffmpeg
    vulkan-tools
  ];
}
