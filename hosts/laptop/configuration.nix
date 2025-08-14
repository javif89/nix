{
  config,
  pkgs,
  inputs,
  hostname,
  ...
}:
{
  imports = [
    ../common-config.nix
    ./hardware-configuration.nix
  ];

  services.xserver.libinput.enable = true;
}
