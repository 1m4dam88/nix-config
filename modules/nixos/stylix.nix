{ pkgs, config, ... }:
{
  stylix.fonts = {
    serif = config.stylix.fonts.sansSerif;
    
    sansSerif = {
      package = pkgs.inter;
      name = "Inter Display";
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
}
