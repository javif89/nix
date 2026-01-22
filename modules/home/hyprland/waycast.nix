{
  pkgs,
  config,
  inputs,
  ...
}:

{
  imports = [ inputs.waycast.homeManagerModules.default ];
  programs.waycast = {
    enable = true;
    settings = {
      plugins.projects = {
        open_command = "zeditor -n {path}";
        search_paths = [
          "/home/javi/projects"
        ];
      };
    };
  };
}
