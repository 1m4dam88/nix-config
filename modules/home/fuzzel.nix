{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "Caskaydia Cove Nerd Font";
        terminal = "foot -e";
        prompt = ">>  ";
        layer = overlay;
      };
      border = {
        radius = 17;
        width = 1;
      };
    };
  };
}
