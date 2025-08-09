{
  config,
  pkgs,
  inputs,
  ...
}:

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
        "/home/javi/Documents/wallpapers/Fantasy-Landscape2.png"
      ];

      wallpaper = [
        ", /home/javi/Documents/wallpapers/Fantasy-Landscape2.png"
      ];
    };
  };
}
