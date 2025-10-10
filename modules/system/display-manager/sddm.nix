{
  config,
  pkgs,
  inputs,
  assets,
  ...
}:
let
  basePath = "/home/javi/Documents/wallpapers";
  wallpaper = "Fantasy-Mountain.png";
in
{
  environment = {
    etc = {
      "sddm-wallpaper.png".source = "${assets}/sddm-background.png";
      "lockscreen.png".source = "${assets}/lockscreen.png";
      "gtk-3.0/settings.ini".text = ''
        [Settings]
        gtk-icon-theme-name=Papirus
        gtk-theme-name=Adwaita
        gtk-cursor-theme-name=Adwaita
      '';
    };

    systemPackages = with pkgs; [
      papirus-icon-theme
      (sddm-chili-theme.override {
        themeConfig = {
          background = "/etc/sddm-wallpaper.png";
          ScreenWidth = "3440";
          ScreenHeight = "1440";
          recursiveBlurLoops = 1;
          recursiveBlurRadius = 10;
        };
      })
    ];

    pathsToLink = [
      "/share/icons"
    ];

    variables = {
      GTK_ICON_THEME = "Papirus";
    };
  };

  programs.dconf.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "chili";
    autoNumlock = true;
    package = pkgs.kdePackages.sddm;
    extraPackages = with pkgs.kdePackages; [
      qtsvg
      qtdeclarative # QtQuick core
    ];
  };
}
