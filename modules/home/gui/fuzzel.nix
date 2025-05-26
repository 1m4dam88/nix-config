{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "foot -e";
        prompt = ">>  ";
        layer = "overlay";
      };
      border = {
        radius = 17;
        width = 1;
      };
    };
  };
}
