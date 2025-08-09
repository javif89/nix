{
  config,
  pkgs,
  inputs,
  ...
}:

{
  home.packages = [
    pkgs.wofi
    pkgs.hyprlock
    pkgs.hyprpaper
  ];

  imports = [
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
      gaps_out = 5;
      gaps_in = 5;
    };

    bind = [
      # Start programs
      "$mod, q, exec, $terminal"
      "$mod SHIFT, o, exec, $browser"
      "$mod SHIFT, p, exec, $browser --incognito"
      "$mod, e, exec, $file_browser"
      "$mod SHIFT, n, exec, kitty --start-as=normal -- bash -ic 'code ~/nix && exit'"
      "$mod, RETURN, exec, $webapphttps://chatgpt.com"

      # Window and workspace navigation
      # Move between windows with vim keys
      "$mod, h, movefocus, l"
      "$mod, l, movefocus, r"
      "$mod, k, movefocus, u"
      "$mod, j, movefocus, d"
      "$mod, c, killactive"
      # Move between workspaces
      "$mod ALT, l, movetoworkspace, r+1"
      "$mod ALT, h, movetoworkspace, r-1"
      "$mod SHIFT, l, workspace, r+1"
      "$mod SHIFT, h, workspace, r-1"
      # Window management
      "$mod, 0, layoutmsg, rollnext"

      "$mod, f, fullscreen, 0"
      "$mod, v, togglefloating, active"
      "$mod, SPACE, exec, wofi --show drun"

      # ", Print, exec, grimblast copy area"

      # "$mod, r, exec, kitty -- zsh -c 'exec yazi; exec zsh'"
      # "$mod, b, exec, kitty -- zsh -c 'btop; exec zsh'"
      # "$mod, y, exec, kitty --start-as=normal -- zsh -ic 'repos'"
      # "$mod, i, exec, brave"
      # "$mod, u, exec, kitty --start-as=normal -- zsh -ic 'home'"

      "$mod SHIFT, s, togglespecialworkspace, comms"
      # "$mod, v, togglespecialworkspace, special2"

      # Log out
      # "$mod, -, exec, hyprctl dispatch exit"
      "$mod SHIFT ALT, x, exec, hyprctl dispatch exit"

      # Shift+Print → select area and copy
      "SHIFT, Print, exec, grimblast copy area"

      # Ctrl+Print → select window and copy
      "CTRL, Print, exec, grimblast copy active"
    ]
    ++ (
      # workspaces
      # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
      builtins.concatLists (
        builtins.genList (
          i:
          let
            ws = i + 1;
          in
          [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]
        ) 9
      )
    );

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
