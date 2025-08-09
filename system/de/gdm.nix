{
  config,
  pkgs,
  inputs,
  ...
}:
{
  services.xserver = {
    enable = true;
    displayManager.gdm = {
      enable = true;
    };
  };
}
