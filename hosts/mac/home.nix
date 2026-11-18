{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../../modules/home/common/git.nix
    ../../modules/home/common/kitty.nix
    ../../modules/home/common/shell.nix
    ../../modules/home/common/starship.nix
    ../../modules/home/common/yazi.nix
    ../../modules/home/common/fzf.nix
    ../../modules/home/common/vscode.nix
    ../../modules/home/common/zed.nix
  ];

  home = {
    username = "javi";
    homeDirectory = "/Users/javi";
    stateVersion = "25.05";

    packages = with pkgs; [
      ffmpeg
      ripgrep
      bat
      eza
      jq
      xh
      rage
      kubectl
      devenv
      nixfmt
      nodejs_24
      php85
      php85Packages.composer
      dotnet-sdk_10
      dotnet-aspnetcore_10
      fastfetch
      dig
      lsof
      gdu
      go
      bun
      pkg-config
      rustup
    ];

    sessionVariables = {
      EDITOR = "code";
      TERMINAL = "kitty";
      XDG_CACHE_HOME = "${config.home.homeDirectory}/.cache";
      XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
      XDG_DATA_HOME = "${config.home.homeDirectory}/.local/share";
      XDG_STATE_HOME = "${config.home.homeDirectory}/.local/state";
      DOTNET_ROOT = "${pkgs.dotnet-sdk_10}/share/dotnet";
    };
  };

  programs = {
    home-manager.enable = true;
    btop.enable = true;

    direnv = {
      enable = true;
      enableZshIntegration = true;
    };

    zsh.shellAliases = {
      rb = lib.mkForce "sudo darwin-rebuild switch --flake ~/nix/hosts/mac#macbook";
      clipboard = lib.mkForce "pbcopy";
    };
  };

  stylix.targets = {
    btop.enable = true;
    zed.enable = true;
  };

  xdg.enable = true;
}
