{ pkgs, inputs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  programs.zsh.enable = true;

  # Match the existing macOS account.
  users.users.javi.home = "/Users/javi";
  system.primaryUser = "javi";

  # Preserve the value from your existing nix-darwin configuration if different.
  system.stateVersion = 5;

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest-dark-hard.yaml";
    polarity = "dark";
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hm.bak";

    extraSpecialArgs = {
      inherit inputs;
      assets = ../../assets;
    };

    users.javi.imports = [ ./home.nix ];
  };
}
