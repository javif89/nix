{
  config,
  pkgs,
  ...
}: {
  # Development-specific configurations and tools

  # Node.js development
  home.packages = with pkgs; [
    # Node.js tools (system-wide installation handled in NixOS config)
    nodePackages.npm
    nodePackages.bun

    # PHP development tools
    phpPackages.composer

    # JSON/YAML tools
    jq
    yq
  ];

  # Development environment variables
  home.sessionVariables = {
    # Node.js
    NODE_ENV = "development";
    NPM_CONFIG_PREFIX = "${config.home.homeDirectory}/.npm-global";

    # PHP
    COMPOSER_HOME = "${config.home.homeDirectory}/.composer";

    # Go
    GOPATH = "${config.home.homeDirectory}/go";
    GOBIN = "${config.home.homeDirectory}/go/bin";

    # Laravel Valet (when using it with Nix)
    PATH = "$PATH:${config.home.homeDirectory}/.composer/vendor/bin";
  };

  # Create development directories
  home.file.".keep-dirs" = {
    text = "";
    onChange = ''
      mkdir -p ${config.home.homeDirectory}/projects
      mkdir -p ${config.home.homeDirectory}/go/{bin,pkg,src}
      mkdir -p ${config.home.homeDirectory}/.composer
      mkdir -p ${config.home.homeDirectory}/.npm-global
    '';
  };

  # Yazi file manager configuration (replaces your yazi.sh script)
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;

    settings = {
      manager = {
        show_hidden = true;
        sort_by = "modified";
        sort_reverse = true;
        linemode = "permissions";
      };

      preview = {
        max_width = 600;
        max_height = 900;
      };

      opener = {
        edit = [
          {
            run = "code \"$@\"";
            block = true;
          }
        ];
        open = [
          {
            run = "xdg-open \"$@\"";
            desc = "Open";
          }
        ];
      };
    };

    keymap = {
      manager.prepend_keymap = [
        {
          on = ["<Esc>"];
          run = "escape";
          desc = "Exit visual mode, clear selected, or cancel search";
        }
        {
          on = ["q"];
          run = "quit";
          desc = "Exit the process";
        }
        {
          on = ["Q"];
          run = "quit --no-cwd-file";
          desc = "Exit the process without writing cwd-file";
        }
        {
          on = ["<C-q>"];
          run = "close";
          desc = "Close the current tab, or quit if it is last tab";
        }
      ];
    };
  };
}
