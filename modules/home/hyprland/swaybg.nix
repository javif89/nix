{ pkgs, assets, ... }:
{
  xdg.configFile."wallpaper.png".source = "${assets}/Forest 1.png";

  home.packages = with pkgs; [
    swaybg
  ];

  systemd.user.services.swaybg = {
    Unit = {
      Description = "swaybg wallpaper";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.swaybg}/bin/swaybg -i %h/.config/wallpaper.png -m fill";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
