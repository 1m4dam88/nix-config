{
  config,
  inputs,
  pkgs,
  host,
  ...
}:
{
  nix.settings = {
    trusted-substituters = [ "https://prismlauncher.cachix.org" ];

    trusted-public-keys = [
      "prismlauncher.cachix.org-1:9/n/FGyABA2jLUVfY+DEp4hKds/rwO+SCOtbOkDzd+c="
    ];
  };
  home.packages = with pkgs; [ prismlauncher ];
}
