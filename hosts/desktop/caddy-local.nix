{
  config,
  pkgs,
  inputs,
  ...
}:
{
  networking.extraHosts = ''
    127.0.0.1 conti.local
  '';

  environment.systemPackages = with pkgs; [
    nss # For certutils
  ];

  services.caddy = {
    enable = true;
    virtualHosts."conti.local" = {
      extraConfig = ''
        reverse_proxy localhost:6167
        tls internal
      '';
    };
  };

  security.pki.certificateFiles = [
    ./caddy-local-root.crt
  ];

  # system.activationScripts.caddyCert = ''
  #   cp /var/lib/caddy/.local/share/caddy/pki/authorities/local/root.crt /etc/ssl/certs/caddy-local.crt
  #   update-ca-certificates
  # '';
}
