# Hyprpanel is archived, and the developer rewrote it
# as "Wayle"
{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:

{
  services.wayle = {
    enable = true;

    settings = {
      bar = {
        layer = "top";
        layout = [
          {
            left = [
              "dashboard"
              "hyprland-workspaces"
              "cpu"
              "ram"
              "systray"
            ];
            middle = [ "clock" ];
            monitor = "*";
            right = [
              "media"
              "volume"
              "network"
              "notifications"
            ];
          }
        ];
        location = "top";
        scale = 0.8;
      };
      modules = {
        hyprland-workspaces = {
          show-special = false;
          display-mode = "icon";
        };
      };
      styling = lib.mkForce {
        # Docs: https://wayle.app/config/types#palette-config
        palette = lib.mkForce {
          bg = "#000000";
          elevated = "#000000";
          # elevated = "#090909";
          fg = "#FFFFFF";
          fg-muted = "#828bb8";
          surface = "#000000";
          primary = "#FFFFFF";

          # All icons set to white
          blue = "#FFFFFF";
          green = "#FFFFFF";
          red = "#FFFFFF";
          yellow = "#FFFFFF";
        };
      };
      wallpaper = {
        engine-enabled = false;
      };
    };
  };
}
