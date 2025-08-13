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
  environment.etc."sddm-wallpaper.png".source = ../../assets/sddm-background.png;
  environment.systemPackages = with pkgs; [
    (sddm-chili-theme.override {
      themeConfig = {
        background = "/etc/sddm-wallpaper.png";
        ScreenWidth = "3440";
        ScreenHeight = "1440";
        recursiveBlurLoops = 1;
        recursiveBlurRadius = 10;
      };
    })
    libsForQt5.qt5.qtgraphicaleffects
    papirus-icon-theme
  ];

  programs.dconf.enable = true;
  environment.etc."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-icon-theme-name=Papirus
    gtk-theme-name=Adwaita
    gtk-cursor-theme-name=Adwaita
  '';

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "chili";
    autoNumlock = true;
    package = pkgs.libsForQt5.sddm;
    extraPackages = with pkgs.libsForQt5.qt5; [
      qtgraphicaleffects
      qtquickcontrols2
      qtquickcontrols
      qtsvg
      qtdeclarative # QtQuick core
    ];
  };
}
