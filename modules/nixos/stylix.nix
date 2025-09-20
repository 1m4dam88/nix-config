{ pkgs, config, ... }:
{
  stylix = {
    enable = true;
    image = ./../../assets/wallpapers/half-life-catppuccin-blue.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";
    opacity.terminal = 1.0;
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
        package = pkgs.nerd-fonts.caskaydia-cove;
        name = "Caskaydia Cove Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
