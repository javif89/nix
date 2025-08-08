{
  config,
  pkgs,
  inputs,
  stable,
  ...
}: {
  imports = [
    ./modules/shell.nix
    ./modules/git.nix
    ./modules/gnome.nix
    ./programs/vscode.nix
    ./programs/starship.nix
    ./programs/development.nix
  ];

  # Home Manager version
  home.stateVersion = "24.05";

  # User info
  home = {
    username = "javi";
    homeDirectory = "/home/javi";
  };

  # Let Home Manager manage itself
  programs.home-manager.enable = true;

  # User packages
  home.packages = with pkgs; [
    # Terminal tools
    yazi # File manager (replacing your yazi.sh script)
    ripgrep # Better grep
    fd # Better find
    bat # Better cat
    delta # Better git diff

    # Development tools
    jetbrains.datagrip # Database IDE (from your Ansible config)

    # System monitoring
    btop
    neofetch
    fastfetch

    # Utilities
    xclip
    wl-clipboard
    flameshot

    # Archive tools
    unzip
    zip
    p7zip

    # Network tools
    curl
    wget

    # Media
    mpc
  ];

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
}
