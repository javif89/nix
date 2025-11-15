{
  config,
  pkgs,
  ...
}:
{
  home.packages = [
    pkgs.git
  ];

  # Git configuration
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "javif89";
        email = "javier0eduardo@hotmail.com";
      };

      init = {
        defaultBranch = "main";
      };

      core = {
        editor = "code --wait";
        autocrlf = "input";
        ignorecase = false;
      };

      pull = {
        rebase = true;
      };

      push = {
        default = "simple";
        autoSetupRemote = true;
      };

      merge = {
        tool = "code";
      };

      diff = {
        tool = "code";
      };

      # Better diff output
      color = {
        ui = true;
      };
    };
  };
}
