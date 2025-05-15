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
  environment.systemPackages = with pkgs; [ 
    pkgs.ffmpegthumbnailer 
    xarchiver
  ];
}
