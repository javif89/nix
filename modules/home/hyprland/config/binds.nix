{
  config,
  pkgs,
  inputs,
  ...
}:

{
  wayland.windowManager.hyprland = {
    extraLuaFiles.bindings = ./binds.lua;
  };
}
