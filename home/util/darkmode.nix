{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:

{

}

# {
#   home.packages = with pkgs; [
#     papirus-icon-theme
#     papirus-folders
#   ];
#   gtk = {
#     enable = true;
#     theme = {
#       name = "Breeze-Dark";
#       package = pkgs.libsForQt5.breeze-gtk;
#     };
#     iconTheme = {
#       name = "Papirus-Dark";
#     };
#     gtk3 = {
#       extraConfig.gtk-application-prefer-dark-theme = true;
#     };
#   };

#   dconf.settings = {
#     "org/gnome/desktop/interface" = {
#       gtk-theme = "Breeze-Dark";
#       color-scheme = "prefer-dark";
#     };
#   };

#   qt = {
#     enable = true;
#     platformTheme = "gtk";
#     style = {
#       name = "gtk2";
#       package = pkgs.libsForQt5.breeze-qt5;
#     };
#   };

#   # Make Qt apps follow dark mode
#   home.sessionVariables = {
#     QT_QPA_PLATFORMTHEME = "gtk2";
#     QT_STYLE_OVERRIDE = "gtk2";
#   };
# }
