{
  config,
  pkgs,
  inputs,
  ...
}:

{
  # Install hyprland and all the stuff it needs
  programs.hyprland.enable = true;
  programs.waybar.enable = true;
  environment.sessionVariables.NIXOS_OZON_WL = "1";

  environment.systemPackages = with pkgs; [
    hyprlock
  ];
}
