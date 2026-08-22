{
  config,
  pkgs,
  inputs,
  assets,
  ...
}:

{
  imports = [
    ./config
    ./wayle.nix
    ./swaybg.nix
    ./desktop-env.nix
    ./screenshots.nix
    ./waycast.nix
    ./hypr-share-picker.nix
  ];

  home = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    packages = with pkgs; [
      # Notifications
      libnotify
      # Desktop env
      # hyprpanel
      hyprpolkitagent
      # Utility
      wl-clipboard
    ];
  };

  # Important for certain apps working
  # and dark mode being respected
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    configType = "lua";

    # TODO: Figure out a cleaner way to start this
    # settings = {
    #   # Window rules
    #   exec-once = [
    #     "systemctl --user start hyprpolkitagent"
    #   ];
    # };
  };
}
