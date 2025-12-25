{
  config,
  pkgs,
  inputs,
  hostname,
  nixos-hardware,
  ...
}:
{
  imports = [
    ../common-config.nix
    ./hardware-configuration.nix
    ./custom.nix
    inputs.nixos-hardware.nixosModules.framework-16-7040-amd
  ];

  services.xserver.libinput.enable = true;

  environment.systemPackages = with pkgs; [
    upower
  ];

  services = {
    upower.enable = true;
    power-profiles-daemon.enable = true;
    fwupd.enable = true;
    # For screen locking/lid closing
    logind = {
      lidSwitch = "suspend";
      lidSwitchExternalPower = "lock";
      lidSwitchDocked = "ignore";
    };
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  environment.variables = {
    # Enable Wayland + Ozone for Chromium apps (VSCode included)
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    ELECTRON_ENABLE_WAYLAND = "1";

    # Some VSCode builds require this instead:
    OZONE_PLATFORM = "wayland";
    OZONE_PLATFORM_HINT = "auto";
  };
}
