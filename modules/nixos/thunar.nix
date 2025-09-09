{ pkgs, config, ... }:
{
  programs.xfconf.enable = true;
  services.tumbler.enable = true;
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
  environment.systemPackages = with pkgs; [ 
    pkgs.ffmpegthumbnailer 
    xarchiver
  ];
}
