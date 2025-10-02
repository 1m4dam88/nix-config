{ pkgs, config, ... }:
{
  stylix = {
    enable = true;
    image = ./../../assets/wallpapers/dark-waves.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";
    opacity.terminal = 0.9;
    cursor.package = pkgs.catppuccin-cursors.mochaBlue;
    cursor.name = "catppuccin-mocha-blue-cursors";
    cursor.size = 24;
    fonts = {
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };
      
      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };

      monospace = {
        package = pkgs.nerd-fonts.caskaydia-mono;
        name = "Caskaydia Mono Nerd Font Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
