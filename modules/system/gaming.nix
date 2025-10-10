{ pkgs, ... }:

{
  # Install Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # in configuration.nix
  networking.firewall.enable = false;
  networking.firewall.allowedUDPPorts = [
    27015
    27036
  ];
  networking.firewall.allowedTCPPorts = [
    27015
    27036
  ];

  environment.systemPackages = with pkgs; [
    gamemode
  ];

  # In your configuration.nix
  hardware.graphics = {
    enable = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];
}
