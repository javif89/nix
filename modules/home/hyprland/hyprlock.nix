{
  inputs,
  assets,
  lib,
  ...
}:
{
  programs.hyprlock = {
    enable = true;

    settings = {
      # Variables
      "$font" = "Monospace";

      general = {
        hide_cursor = false;
      };

      animations = {
        enabled = true;
        bezier = "linear, 1, 1, 0, 0";
        animation = [
          "fadeIn, 1, 5, linear"
          "fadeOut, 1, 5, linear"
          "inputFieldDots, 1, 2, linear"
        ];
      };

      background = lib.mkForce [
        {
          monitor = "";
          path = "/etc/lockscreen.png";
          blur_passes = 1;
        }
      ];

      # input-field = [
      #   {
      #     monitor = "";
      #     size = "20%, 5%";
      #     fade_on_empty = false;
      #     rounding = 15;
      #     font_family = "$font";
      #     placeholder_text = "Input password...";
      #     fail_text = "$PAMFAIL";
      #     # Uncomment to use a letter instead of a dot to indicate the typed password
      #     # dots_text_format = "*";
      #     # dots_size = 0.4;
      #     dots_spacing = 0.3;
      #     # Uncomment to use an input indicator that does not show the password length
      #     # hide_input = true;
      #     position = "0, -20";
      #     halign = "center";
      #     valign = "center";
      #   }
      # ];

      # Labels are defined as a list since there are multiple
      label = [
        # TIME
        {
          monitor = "";
          text = "$TIME"; # ref. https://wiki.hyprland.org/Hypr-Ecosystem/hyprlock/#variable-substitution
          font_size = 90;
          font_family = "$font";
          position = "-30, 0";
          halign = "right";
          valign = "top";
        }
        # DATE
        {
          monitor = "";
          text = ''cmd[update:60000] date +"%A, %d %B %Y"''; # update every 60 seconds
          font_size = 25;
          font_family = "$font";
          position = "-30, -150";
          halign = "right";
          valign = "top";
        }
      ];
    };
  };

  stylix.targets.hyprlock = {
    useWallpaper = true;
  };
}
