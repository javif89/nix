{ pkgs, lib, ... }:

let
  picker = pkgs.thegrind.hypr-share-picker;
in
{
  home.packages = [ picker ];

  # XDPH probes for a binary named `hyprland-share-picker` by default, so it has
  # to be told about this one explicitly.
  xdg.configFile."hypr/xdph.conf".text = ''
    screencopy {
      custom_picker_binary = ${lib.getExe picker}
    }
  '';
}
