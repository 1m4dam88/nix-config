{ pkgs, config, ... }:
{
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
      tumbler
    ];
  };
  home.packages = with pkgs; [ 
    pkgs.ffmpegthumbnailer 
    xarchiver
  ];
}
