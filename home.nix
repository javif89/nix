{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    ./home/kitty.nix
    ./home/shell.nix
    ./home/starship.nix
    ./home/git.nix
    ./home/hyprland.nix
    ./home/util/darkmode.nix
    ./home/neovim.nix
  ];
  nixpkgs.config.allowUnfree = true;
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "javi";
  home.homeDirectory = "/home/javi";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # Basics
    quickshell

    # Terminal tools
    yazi
    ripgrep
    fzf
    bat
    eza
    jq

    # Dev tools
    jetbrains.datagrip
    vscode
    nixfmt # Nix formatting
    pkgs.libsForQt5.full # QML formatting (for working on quickshell)

    # System tools
    btop
    fastfetch
    gnumake

    # Langs
    php
    php84Packages.composer
    laravel
    go
    nodejs_22
    bun
  ];

  programs.btop = {
    enable = true;
  };

  programs.yazi = {
    enable = true;
    keymap = {
      manager.prepend_keymap = [
        {
          on = [
            "b"
            "g"
          ];
          run = "shell 'hyprctl hyprpaper preload \"$0\" && hyprctl hyprpaper wallpaper \", $0\"'";
          desc = "Set as wallpaper";
        }
      ];
    };
  };

  stylix = {
    enable = true;
    targets = {
      btop.enable = true;
    };
  };

  # Environment variables
  home.sessionVariables = {
    EDITOR = "code";
    BROWSER = "brave";
    TERMINAL = "kitty";
    NVD_BACKEND = "wayland";
    OZONE_PLATFORM = "wayland";
    OZONE_PLATFORM_HINT = "auto";
    XDG_CACHE_HOME = "${config.home.homeDirectory}/.cache";
    XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
    XDG_DATA_HOME = "${config.home.homeDirectory}/.local/share";
    XDG_STATE_HOME = "${config.home.homeDirectory}/.local/state";
  };

  # Configure all the xdg stuff so apps work correctly
  xdg = {
    enable = true;
    # Normal expected directories
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "${config.home.homeDirectory}/Desktop";
      documents = "${config.home.homeDirectory}/Documents";
      download = "${config.home.homeDirectory}/Downloads";
      music = "${config.home.homeDirectory}/Music";
      pictures = "${config.home.homeDirectory}/Pictures";
      publicShare = "${config.home.homeDirectory}/Public";
      templates = "${config.home.homeDirectory}/Templates";
      videos = "${config.home.homeDirectory}/Videos";
    };

    # TODO: Move the http handler to a browser.nix
    #   # File/app associations
    #   mimeApps = {
    #     enable = true;
    #     defaultApplications = {
    #       "text/html" = "brave.desktop";
    #       "x-scheme-handler/http" = "brave.desktop";
    #       "x-scheme-handler/https" = "brave.desktop";
    #       "x-scheme-handler/about" = "brave.desktop";
    #       "x-scheme-handler/unknown" = "brave.desktop";
    #       "application/pdf" = "org.gnome.Evince.desktop";
    #       "text/plain" = "code.desktop";
    #       "application/json" = "code.desktop";
    #       "application/javascript" = "code.desktop";
    #       "text/x-php" = "code.desktop";
    #     };
    #   };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
