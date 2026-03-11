{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  systemd.services."lock-before-sleep" = {
    description = "Lock before suspend";
    before = [ "sleep.target" ];
    wantedBy = [ "sleep.target" ];
    script = "hyprctl dispatch exec hyprlock";
    serviceConfig = {
      Type = "oneshot";
      User = "javier";
    };
  };

  home-manager.users."javi" = {
    home.packages = with pkgs; [
      brightnessctl
    ];

    home.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      ELECTRON_ENABLE_WAYLAND = "1";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      OZONE_PLATFORM = "wayland";
      OZONE_PLATFORM_HINT = "auto";
    };

    wayland.windowManager.hyprland = {
      settings = {
        monitor = [
          "eDP-1, 2560x1600@165.00, 0x0, 1.6"
        ];

        # windowrulev2 = lib.mkForce [
        #   "opacity 0.95, class:^(Code)$"
        #   "opacity 0.95, class:^(code)$"
        #   "opacity 0.95, class:^(Zed)$"
        # ];

        gesture = [
          "3, horizontal, workspace"
        ];

        # Media Keys
        bindle = [
          # Brightness
          ",XF86MonBrightnessUp,exec,brightnessctl set +5%"
          ",XF86MonBrightnessDown,exec,brightnessctl set 5%-"

          # Volume
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ];
      };
    };

    services = {
      # Screen locking/suspend/lid close
      hypridle = {
        enable = true;
        settings = {
          general = {
            lock_cmd = "hyprlock";
            before_sleep_cmd = "hyprlock";
          };
          listener = [
            {
              timeout = 300;
              on-timeout = "hyprlock";
            }
            {
              timeout = 330;
              on-timeout = "systemctl suspend";
            }
          ];
        };
      };
    };

    programs = {
      hyprpanel.settings.bar.layouts = {
        "0" = {
          left = [
            "dashboard"
            "workspaces"
            "cpu"
            "ram"
            "systray"
          ];
          middle = [
            "clock"
          ];
          right = [
            "media"
            "volume"
            "network"
            "bluetooth"
            "notifications"
            "battery"
          ];
        };
      };
    };
  };
}
