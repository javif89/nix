{ lib, pkgs, ... }:

let
  nasIp = "10.89.0.15";
  baseMnt = "/mnt/main";
  shares = [
    "backups"
    "container-data"
    "javi"
    "xrandr"
    "media"
    "fileshare"
    "music"
    "prod-cluster"
  ];

  configureShare = share: {
    name = "/mnt/network-shares/${share}";
    value = {
      device = "${nasIp}:${baseMnt}/${share}";
      fsType = "nfs";
      options = [
        "x-systemd.automount"
        "noauto"
        "rw"
        "vers=4.2"
        "nconnect=8"
        "rsize=1048576"
        "wsize=1048576"
        "noatime"
      ];
    };
  };

  shareConfig = map configureShare shares;
  fsConfig = builtins.listToAttrs shareConfig;

in
{
  # Enable NFS client support
  boot.supportedFilesystems = [ "nfs" ];
  services = {
    rpcbind.enable = true; # Required for NFS
    gvfs.enable = true;
    udisks2.enable = true;
  };

  # Add NFS utilities
  environment.systemPackages = with pkgs; [
    nfs-utils
  ];

  fileSystems = fsConfig;
  systemd.tmpfiles.rules = map (share: "d /mnt/${share} 0755 root root -") shares;
}
