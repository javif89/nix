{
  config,
  pkgs,
  inputs,
  ...
}:
{
  programs.yazi = {
    enable = true;
    shellWrapperName = "yy";
    keymap = {
      manager.prepend_keymap = [
        {
          on = [
            "b"
            "g"
          ];
          run = "shell 'hyprctl hyprpaper preload \"$0\" && hyprctl hyprpaper wallpaper \", $0\"'";
          desc = "Set as wallpaper";
        }
      ];
    };
  };
}
