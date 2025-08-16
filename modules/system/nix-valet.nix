/*
  This module gives the same functionality as laravel valet or valet linux.

  Set up DNSMasq to point all *.test domains to caddy.

  Caddy will look for a folder with the same name in ~/projects and serve it.
*/
{
  config,
  pkgs,
  lib,
  ...
}:
let
  customCaddy = pkgs.xcaddy {
    pname = "caddy-frankenphp";
    version = "2.7.6";

    subPackages = [ "cmd/caddy" ];

    plugins = [
      "github.com/dunglas/frankenphp/caddy"
    ];
  };
in
{
  services = {
    # Enable dnsmasq
    dnsmasq = {
      enable = true;
      settings = {
        # Point all .test domains to localhost
        address = "/.test/127.0.0.1";
        # Don't forward .test queries to upstream DNS
        # server = "/test/";
        # Listen on localhost only
        listen-address = "127.0.0.1";
        # Bind to interface
        bind-interfaces = true;
        # Cache size
        cache-size = 1000;
        # Don't read /etc/hosts
        no-hosts = true;
        # Don't poll /etc/resolv.conf
        no-poll = true;
      };
    };

    # Enable PHP-FPM
    phpfpm = {
      pools.www = {
        user = "javi";
        group = "users";
        settings = {
          "listen.owner" = "javi";
          "listen.group" = "users";
          "listen.mode" = "0660";
          "pm" = "dynamic";
          "pm.max_children" = 32;
          "pm.start_servers" = 2;
          "pm.min_spare_servers" = 2;
          "pm.max_spare_servers" = 4;
          "pm.max_requests" = 500;
        };
        phpEnv."PATH" = lib.makeBinPath [ pkgs.php ];
      };
    };

    # Enable Caddy
    caddy = {
      enable = true;
      package = customCaddy;
      globalConfig = ''
        auto_https off
        frankenphp
        order php_server before file_server 
      '';
      extraConfig = ''
        # Specific subdomain first (more specific routes come first)
        http://caddytest.test {
            respond "We in caddyland"
        }

        # Wildcard for other .test domains
        http://*.test {
            root * /home/javi/projects/{labels.1}/public
            php_server
        }
      '';
    };

    # Configure system to use local dnsmasq for .test domains
    resolved = {
      enable = true;
      domains = [ "~test" ];
      fallbackDns = [
        "10.89.0.1"
        # "8.8.8.8"
        # "1.1.1.1"
      ];
      extraConfig = ''
        DNS=127.0.0.1#53
        Domains=~test
        DNSSEC=false
      '';
    };
  };

  # Install PHP and related packages
  environment.systemPackages = with pkgs; [
    # Add common PHP extensions you might need
    php84Extensions.mbstring
    php84Extensions.xml
    php84Extensions.curl
    php84Extensions.zip
    php84Extensions.gd
    php84Extensions.intl
    php84Extensions.bcmath
    php84Extensions.soap
    php84Extensions.mysqli
    php84Extensions.pdo_mysql
    php84Extensions.pgsql
    php84Extensions.pdo_sqlite
  ];

  # Create a dedicated caddy config directory
  systemd.tmpfiles.rules = [
    "d /var/lib/caddy 0755 javi users -"
  ];

  systemd.services.caddy = {
    serviceConfig = {
      User = lib.mkForce "javi";
      Group = lib.mkForce "users";
      # More comprehensive capabilities
      AmbientCapabilities = [
        "CAP_NET_BIND_SERVICE"
        "CAP_SETUID"
        "CAP_SETGID"
      ];
      CapabilityBoundingSet = [
        "CAP_NET_BIND_SERVICE"
        "CAP_SETUID"
        "CAP_SETGID"
      ];
      # Keep it simple - just set the config directory
      Environment = [ "XDG_CONFIG_HOME=/var/lib/caddy" ];
      # Ensure the working directory is accessible
      WorkingDirectory = "/var/lib/caddy";
    };
  };

  # And make sure your user is in the caddy group
  users.users.javi = {
    extraGroups = [
      "users"
    ];
  };
}
