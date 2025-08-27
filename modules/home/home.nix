{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    ./common/git.nix
    ./common/kitty.nix
    ./common/neovim.nix
    ./common/shell.nix
    ./common/starship.nix
    ./common/yazi.nix
    ./common/fzf.nix
    ./common/vscode.nix
    ./hyprland
  ];

  nixpkgs.config.allowUnfree = true;

  # gtk = {
  #   enable = true;
  #   iconTheme = {
  #     name = "Papirus";
  #     package = pkgs.papirus-icon-theme;
  #   };
  # };
  home = {
    username = "javi";
    homeDirectory = "/home/javi";
    stateVersion = "25.05"; # Home manager version. Do not update carelessly
    packages = with pkgs; [
      # Basics
      quickshell
      zoom-us
      obsidian
      kdePackages.kdenlive
      ffmpeg

      # Terminal tools
      ripgrep
      bat
      eza
      jq

      # Dev tools
      jetbrains.datagrip
      vscode
      nixfmt # Nix formatting
      pkgs.libsForQt5.full # QML formatting (for working on quickshell)
      claude-code
      xsel
      nss.tools
      ansible

      # System tools
      btop
      fastfetch
      gnumake
      dig
      lsof

      # Langs
      php
      php84Packages.composer
      laravel
      go
      nodejs_22
      bun
      zls # Zig language server
    ];

    sessionVariables = {
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
      QT_QPA_PLATFORM = "wayland";
    };
  };

  # Programs home manager should manage
  programs = {
    btop = {
      enable = true;
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
    };
  };

  stylix = {
    enable = true;
    targets = {
      btop.enable = true;
    };
  };

  xdg = {
    enable = true;
    configFile."user-dirs.conf" = {
      text = ''
        enabled=True
        filename_encoding=UTF-8
      '';
      force = true; # This forces overwrite of existing content
    };
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
