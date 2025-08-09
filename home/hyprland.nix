{
  config,
  pkgs,
  inputs,
  ...
}:

{
  home.packages = [
    pkgs.wofi
    # pkgs.hyprlock
    pkgs.mako
    pkgs.libnotify
  ];

  imports = [
    # Configs
    ./hyprland/binds.nix
    # Ecosystem
    ./hyprland/hyprpaper.nix
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
    "$mod" = "SUPER";
    "$browser" = "brave";
    "$terminal" = "kitty";
    "$file_browser" = "nautilus";
    "$webapp" = "$browser --new-window --app=";

    monitor = [
      "DP-5, 3440x1440@179.99, 0x0, 1"
    ];

    general = {
      layout = "master";
      gaps_out = 10;
      gaps_in = 10;
    };

    workspace = [
      1
      2
      3
      4
      5
      6
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
      "eval $(gnome-keyring-daemon --start --components=secrets,ssh,gpg)"
    ];
  };

  wayland.windowManager.hyprland.plugins = [
    # inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprbars
  ];

}
