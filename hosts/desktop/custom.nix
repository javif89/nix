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
          "DP-5, 3440x1440@179.99, 0x0, 1"
        ];

        # windowrulev2 = lib.mkForce [
        #   "opacity 0.95, class:^(Code)$"
        #   "opacity 0.95, class:^(code)$"
        #   "opacity 0.95, class:^(Zed)$"
        # ];
      };
    };

    programs = {
      # DEPRECATED:
      # 1. I no longer have laptop so this doesn't have
      # to be in "custom.nix"
      # 2. Hyprpanel is deprecated and is now wayle
      #   hyprpanel.settings.bar.layouts = {
      #     "0" = {
      #       left = [
      #         "dashboard"
      #         "workspaces"
      #         "cpu"
      #         "ram"
      #         "systray"
      #       ];
      #       middle = [
      #         "clock"
      #       ];
      #       right = [
      #         "media"
      #         "volume"
      #         "network"
      #         "notifications"
      #       ];
      #     };
      #   };
    };
  };
}
