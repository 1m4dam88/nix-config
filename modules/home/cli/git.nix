{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "1m4dam88";
    userEmail = "171095855+1m4dam88@users.noreply.github.com";
    credential.helper = "store";

    extraConfig = {
      init.defaultBranch = "master";
    };
  };

  home.packages = [ pkgs.gh ];

  environment.etc."git-credentials" = {
    text = ''
      https://ye:${lib.fileContents config.sops.secrets.git_token.path}@github.com
    '';
    mode = "0400";
    user = "ye"; # Replace with your user
    group = "users";
  };

  # Ensure the credential file is used
  home-manager.users.ye = { # If using Home-Manager
    home.file.".git-credentials".source = "/etc/git-credentials";
  };
}
