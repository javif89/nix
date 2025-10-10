{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:

let
  themeDirectory = "${config.programs.hyprpanel.package}/share/themes";
  currentTheme = "gruvbox_vivid";
  raw = lib.importJSON "${themeDirectory}/${currentTheme}.json";
  selectedTheme = if raw ? theme then raw.theme else raw;

  # We need to turn the theme json into a nested attribute set. Otherwise we
  # end up with an incorrect configuration that looks like:
  # theme: {theme.bar.transparent: "value", theme.foo.bar: "another value"}
  # when what we really want is: theme: {bar: ..., buttons: ...}
  # ----
  # turn "foo.bar.baz" and value into { foo = { bar = { baz = value; }; }; }
  nestAttr = path: value: lib.attrsets.setAttrByPath (lib.splitString "." path) value;

  # merge a flat attrset into nested
  unflatten =
    flat:
    lib.foldlAttrs (
      acc: k: v:
      lib.recursiveUpdate acc (nestAttr k v)
    ) { } flat;

  themeAttrs = unflatten selectedTheme;
  base = themeAttrs.theme;
  themeOverrides = {
    font.size = "14px";
    bar.background = lib.mkForce "#000000";
  };

  finalTheme = lib.recursiveUpdate base themeOverrides;
in
{
  programs.hyprpanel = {
    enable = true;
    settings = {
      bar = {
        layouts = {
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
              "notifications"
            ];
          };
        };
      };

      bar.launcher.autoDetectIcon = true;
      bar.workspaces.show_icons = true;

      menus.clock = {
        time = {
          military = false;
          hideSeconds = true;
        };
        weather.unit = "imperial";
      };

      menus.dashboard.directories.enabled = false;
      menus.dashboard.stats.enable_gpu = true;

      # theme = builtins.fromJSON (builtins.readFile "${themeDirectory}/${currentTheme}.json");
      theme = lib.mkForce finalTheme;
    };
  };
}
