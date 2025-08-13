{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Configs
    ./hyprland/binds.nix
    # Ecosystem
    ./hyprland/hyprpaper.nix
    # Desktop environment
    ./hyprland/hyprpanel.nix
    ./wofi.nix
    ./hyprland/desktop-env.nix
  ];

  home.packages = with pkgs; [
    # Running apps
    # wofi

    # Notifications
    libnotify

    # Screenshots
    grim
    slurp
    wl-clipboard
    hyprshot

    # Desktop env
    hyprpanel

    # Utility
    wl-clipboard
  ];

  # Important for certain apps working
  # and dark mode being respected
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  wayland.windowManager.hyprland.enable = true;

  wayland.windowManager.hyprland.settings = {
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

  wayland.windowManager.hyprland.plugins = [
    # inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprbars
  ];

}
