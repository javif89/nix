{
  config,
  pkgs,
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
    starship
    nautilus

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
    neovim
    nixfmt # Nix formatting

    # System tools
    btop
    fastfetch

    # Util
    xclip
    flameshot

    # Media
    mpc
  ];

  # Environment variables
  home.sessionVariables = {
    EDITOR = "code";
    BROWSER = "brave";
    TERMINAL = "kitty";
  };

  # File associations
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "brave-browser.desktop";
      "x-scheme-handler/http" = "brave-browser.desktop";
      "x-scheme-handler/https" = "brave-browser.desktop";
      "x-scheme-handler/about" = "brave-browser.desktop";
      "x-scheme-handler/unknown" = "brave-browser.desktop";
      "application/pdf" = "org.gnome.Evince.desktop";
      "text/plain" = "code.desktop";
      "application/json" = "code.desktop";
      "application/javascript" = "code.desktop";
      "text/x-php" = "code.desktop";
    };
  };

  # XDG directories
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "${config.home.homeDirectory}/Desktop";
      documents = "${config.home.homeDirectory}/Documents";
      download = "${config.home.homeDirectory}/Downloads";
      music = "${config.home.homeDirectory}/Music";
      pictures = "${config.home.homeDirectory}/Pictures";
      videos = "${config.home.homeDirectory}/Videos";
      templates = "${config.home.homeDirectory}/Templates";
      publicShare = "${config.home.homeDirectory}/Public";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
