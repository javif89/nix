{
  config,
  pkgs,
  inputs,
  ...
}:

let
  basePath = "/home/javi/Documents/wallpapers";
  wallpaper = "Fantasy-Mountain.png";
in
{
  home.packages = [
    pkgs.hyprpaper
  ];
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      preload = [
        "${basePath}/${wallpaper}"
      ];

      wallpaper = [
        ", ${basePath}/${wallpaper}"
      ];
    };
  };
}
