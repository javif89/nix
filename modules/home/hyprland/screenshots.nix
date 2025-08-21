{
  config,
  pkgs,
  inputs,
  ...
}:

{
  nixpkgs.config.packageOverrides = pkgs: {
    flameshot = pkgs.flameshot.override {
      enableWlrSupport = true;
    };
  };

  home.packages = with pkgs; [
    flameshot
    grim
    slurp
  ];
}
