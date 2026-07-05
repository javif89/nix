{
  config,
  pkgs,
  inputs,
  ...
}:

{
  home-manager = {
    users."javi" = {
      wayland.windowManager.hyprland = {
        settings = {
          monitor = [
            "DP-2, 3440x1440@179.99, 0x0, 1"
          ];
        };
      };
    };
  };

}
