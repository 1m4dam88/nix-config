{ pkgs, config, ... }:
{
  stylix.fonts = {
    serif = config.stylix.fonts.sansSerif;
    
    sansSerif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
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

  stylix.enable = true;
  stylix.image = ./../../wallpapers/urban_architecture.jpg;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
  stylix.polarity = "dark";
  stylix.opacity.terminal = 1.0;
  stylix.cursor.package = pkgs.bibata-cursors;
  stylix.cursor.name = "Bibata-Modern-Ice";
  stylix.cursor.size = 24;
}
