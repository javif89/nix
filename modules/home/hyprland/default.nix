{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./binds.nix
    ./hyprpaper.nix
    ./hyprpanel.nix
    ./wofi.nix
    ./desktop-env.nix
    ./screenshots.nix
  ];

  home = {
    sessionVariables = {
      NIXOS_OZON_WL = "1";
    };

    packages = with pkgs; [
      # Notifications
      libnotify
      # Desktop env
      hyprpanel
      # Utility
      wl-clipboard
    ];
  };

  # Important for certain apps working
  # and dark mode being respected
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
  };

  wayland.windowManager.hyprland = {

    enable = true;

    settings = {

      input = {
        repeat_delay = 200;
        repeat_rate = 20;
      };

      monitor = [
        "DP-5, 3440x1440@179.99, 0x0, 1"
      ];

      general = {
        layout = "master";
        gaps_out = 0;
        gaps_in = 0;
      };

      workspace = [
        "1, persistent:true"
        "2, persistent:true"
        "3, persistent:true"
        "4, persistent:true"
        "5, persistent:true"
        "6, persistent:true"
      ];

      # Window rules
      windowrulev2 = [
        "opacity 0.85, class:^(Code)$"
      ];

      decoration = {
        blur = {
          enabled = false;
          size = 8;
          passes = 2;
        };

        active_opacity = 1.0;
        inactive_opacity = 1.0;
      };

      exec-once = [
        # "quickshell -c hyprshell"
        "hyprpanel"
      ];
    };

    plugins = [
      # inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprbars
    ];
  };
}
