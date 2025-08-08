{
  config,
  lib,
  pkgs,
  ...
}: let
  kittyConfig = ''
    include current-theme.conf

    font_size 16.0

    background_opacity 0.9
    background_blur 1

    hide_window_decorations yes

    map ctrl+shift+t new_tab_with_cwd
  '';
in {
  programs.kitty = {
    enable = true;

    extraConfig = kittyConfig;

    # Optional: link extra files like `current-theme.conf`
    # Add this if you have a custom theme file
    # settings = {
    #   include = "~/.config/kitty/current-theme.conf";
    # };
  };
}
