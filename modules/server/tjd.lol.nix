{
  pkgs,
  lib,
  config,
  ...
}:
let
  domain = "tjd.lol";
  fqdn = "${domain}";
  baseUrl = "https://${fqdn}";
in
{

  security.acme = {
    acceptTerms = true;
    certs."${domain}".email = "${config.sops.secrets.email}";
  };
}
