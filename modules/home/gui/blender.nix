{
  config,
  inputs,
  pkgs,
  host,
  ...
}:
{
  home.packages = with pkgs; [ blender ];
}
