{
  config,
  pkgs,
  inputs,
  assets,
  ...
}:

{
  imports = [
    ./binds.nix
    ./hyprpanel.nix
    ./hyprlock.nix
    ./swaybg.nix
    ./wofi.nix
    ./desktop-env.nix
    ./screenshots.nix
    ./waycast.nix
  ];

  home = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";

      HYPR_PLUGIN_DIR = pkgs.symlinkJoin {
        name = "hyprland-plugins";
        paths = with pkgs.hyprlandPlugins; [
          hyprexpo
        ];
      };
    };

    packages = with pkgs; [
      # Notifications
      libnotify
      # Desktop env
      hyprpanel
      hyprpolkitagent
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
    systemd.enable = true;

    plugins = with pkgs.hyprlandPlugins; [
      hyprexpo
    ];

    settings = {

      input = {
        repeat_delay = 200;
        repeat_rate = 20;
      };

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
      windowrule = [
        "match:class code, opacity 0.9"
      ];

      layerrule = [
        "no_anim on, match:namespace Waycast"
        "blur on, match:namespace Waycast"
      ];

      animations = {
        animation = "workspaces, 1, 2.5, default";
      };

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
        "hypridle"
        "systemctl --user start hyprpolkitagent"
      ];
    };
  };
}
