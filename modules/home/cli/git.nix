{ lib, config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "1m4dam88";
    userEmail = "171095855+1m4dam88@users.noreply.github.com";

    extraConfig = {
      init.defaultBranch = "master";
      credential.helper = "store";
      url."https://github.com/".insteadOf = "git@github.com:"; # Prefer HTTPS
    };
  };

  home.packages = [ pkgs.gh ];

  home.file.".git-credentials" = {
    text = ''
      https://1m4dam88:${config.sops.secrets.git_token.path}@github.com
    ''; # Replace alice123 with your GitHub username
  };

  home.activation.setGitCredentialsPermissions = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ${pkgs.coreutils}/bin/chmod 0400 ~/.git-credentials || true
  '';

  # Ensure the credential file is used
}
