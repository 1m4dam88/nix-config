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
  home.Packages = with pkgs; [ 
    pkgs.ffmpegthumbnailer 
    xarchiver
  ];
}
