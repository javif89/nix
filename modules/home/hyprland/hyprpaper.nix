{
  config,
  pkgs,
  inputs,
  assets,
  ...
}:

{
  home.packages = [
    pkgs.hyprpaper
  ];
  # Home Manager
  xdg.configFile."wallpaper.png".source = "${assets}/Fantasy-Landscape3.png";
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      preload = [
        "/home/javi/.config/wallpaper.png"
      ];

      wallpaper = [
        ", /home/javi/.config/wallpaper.png"
      ];
    };
  };
}
