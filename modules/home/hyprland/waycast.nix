{
  pkgs,
  config,
  inputs,
  ...
}:

{
  imports = [ inputs.thegrind-nixpkgs.homeManagerModules.waycast ];
  programs.waycast = {
    enable = true;
    settings = {
      projects = {
        open_command = "code -n {path}";
        search_paths = [
          "/home/javi/projects"
        ];
      };
      files = {
        search_paths = [
          "~/Downloads"
          "~/Documents"
        ];
      };
      ui = {
        item_display_variant = "full";
        window_size = {
          width = 800;
          height = 500;
        };
      };
    };
  };
}
