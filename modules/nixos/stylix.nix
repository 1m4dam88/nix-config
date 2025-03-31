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
  stylix.image = ./../../wallpapers/blue.png;
  stylix.polarity = "dark";
  stylix.opacity.terminal= 0.9;
  stylix.cursor.package = pkgs.bibata-cursors;
  stylix.cursor.name = "Bibata-Modern-Ice";
  stylix.cursor.size = 24;
}
