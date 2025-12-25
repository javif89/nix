{
  config,
  pkgs,
  inputs,
  hostname,
  assets,
  ...
}:
{
  imports = [
    ../common-config.nix
    ../../modules/system/nix-valet.nix
    ../../modules/system/device-management/logitech.nix
    ./hyprland/monitors.nix
    ./hardware-configuration.nix
  ];

  # Mount second hard drive
  boot = {
    supportedFilesystems = [
      "ntfs"
    ];
  };

  programs.ssh.extraConfig = "
    Host myhost
      Hostname gitgud.foo 
    Host gitgud.boo
      HostName 10.89.0.102
      User git
      Port 222
      PubkeyAuthentication yes
      ForwardAgent yes
      IdentitiesOnly yes
      IdentityFile ~/.ssh/id_gitea_key
  ";

  fileSystems."/home/javi/working-files" = {
    device = "/dev/disk/by-uuid/BE8EBBDA8EBB8A03";
    fsType = "ntfs";
    options = [
      "uid=1000" # your user ID (check with `id -u`)
      "gid=100" # your primary group ID (check with `id -g`)
      "dmask=022" # dir permissions
      "fmask=022" # file permissions
      "umask=0022"
      "nofail"
      "exec"

      # make Nautilus show it with a friendly name/icon
      "x-gvfs-show"
      "x-gvfs-name=Working Files"
    ];
  };

  virtualisation.docker.enable = true;
  users.users.javi.extraGroups = [ "docker" ];

  # networking.hosts = {
  #   "127.0.0.1" = [
  #     "howtohomelab.fyi"
  #   ];
  # };

  environment = {
    systemPackages = with pkgs; [
      pkgs.ntfs3g
      obs-studio
    ];
  };
}
