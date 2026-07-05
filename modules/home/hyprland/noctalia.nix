{
  config,
  pkgs,
  inputs,
  assets,
  ...
}:

{
  # environment.systemPackages = with pkgs; [
  #   inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  # ];
  imports = [
    inputs.noctalia.homeModules.default
  ];

  xdg.configFile."wallpaper.png".source = "${assets}/Forest 1.png";
  home.file.".cache/noctalia/wallpapers.json" = {
    text = builtins.toJSON {
      wallpapers = {
        "DP-5" = ".config/wallpaper.png";
      };
    };
  };
  programs.noctalia-shell = {
    enable = true;
    settings = {
      bar = {
        density = "compact";
        position = "top";
        showCapsule = true;
        widgets = {
          left = [
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
            {
              hideUnoccupied = false;
              id = "Workspace";
              labelMode = "none";
            }
          ];
          center = [
            {
              formatHorizontal = "HH:mm";
              formatVertical = "HH mm";
              id = "Clock";
              useMonospacedFont = true;
              usePrimaryColor = true;
            }
          ];
          right = [
            {
              id = "Network";
            }
          ];
        };
      };
      colorSchemes.predefinedScheme = "Monochrome";
      general = {
        avatarImage = "/home/javi/.face.icon";
        radiusRatio = 0.2;
      };
      location = {
        monthBeforeDay = true;
        name = "Orlando, Florida";
      };
    };
    # this may also be a string or a path to a JSON file.
  };
}
