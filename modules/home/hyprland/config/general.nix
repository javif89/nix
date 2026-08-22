{
  config,
  pkgs,
  inputs,
  ...
}:

{
  wayland.windowManager.hyprland.settings = {
    config.input = {
      repeat_delay = 200;
      repeat_rate = 20;
    };

    config.general = {
      layout = "master";
      gaps_out = 0;
      gaps_in = 0;
    };

    config.decoration = {
      blur = {
        enabled = false;
        size = 8;
        passes = 2;
      };

      active_opacity = 1.0;
      inactive_opacity = 1.0;
    };

    workspace_rule = [
      {
        workspace = "1";
        persistent = true;
      }
      {
        workspace = "2";
        persistent = true;
      }
      {
        workspace = "3";
        persistent = true;
      }
      {
        workspace = "4";
        persistent = true;
      }
      {
        workspace = "5";
        persistent = true;
      }
      {
        workspace = "6";
        persistent = true;
      }
    ];

    window_rule = [
      {
        match.class = "code";
        opacity = 0.9;
      }
      {
        match.title = "waycast-dev";
        no_initial_focus = true;
      }
    ];

    layer_rule = [
      {
        match.namespace = "Waycast";
        no_anim = true;
      }
    ];

    animation = {
      leaf = "workspaces";
      enabled = true;
      speed = 2.5;
      bezier = "default";
    };
  };
}
