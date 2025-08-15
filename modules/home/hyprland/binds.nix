{
  config,
  pkgs,
  inputs,
  ...
}:

{
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    "$browser" = "brave";
    "$terminal" = "kitty";
    "$file_browser" = "thunar";
    "$webapp" = "$browser --new-window --app=";

    binds = {
      drag_threshold = 10;
    };

    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];

    bind = [
      # Start programs
      "$mod, q, exec, $terminal"
      "$mod SHIFT, o, exec, $browser"
      "$mod SHIFT, p, exec, $browser --incognito"
      "$mod, e, exec, $file_browser"
      "$mod SHIFT, n, exec, code ~/nix"
      "$mod SHIFT, ESC, exec, $terminal --start-as=normal -- bash -ic 'btop'"
      # "$mod ALT, p, exec, $terminal --start-as=normal -- bash -ic 'proj'"

      "$mod ALT, p, exec, eza -ld $HOME/projects/* --color=never | awk '{print $7}' | wofi --dmenu --prompt \"Open project:\" | xargs -I{} code {} -n && exit"
      "$mod, RETURN, exec, $webapphttps://claude.ai"

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
      "$mod, d, exec, ${pkgs.wofi-emoji}/bin/wofi-emoji"

      "$mod SHIFT, s, exec, hyprshot --mode region"
      ", PRINT, exec, hyprshot --mode output"

      "$mod SHIFT, c, togglespecialworkspace, comms"
      "$mod SHIFT, a, togglespecialworkspace, research"
      "$mod SHIFT ALT, x, exec, hyprctl dispatch exit"
      "SHIFT, Print, exec, grimblast copy area"
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
  };

  wayland.windowManager.hyprland.plugins = [
    # inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprbars
  ];

}
