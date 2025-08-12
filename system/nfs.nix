{ lib, ... }:

let
  nasIp = "10.89.0.15";
  baseMnt = "/mnt/main";
  shares = [
    "backups"
    "container-data"
    "javi"
  ];

  configureShare = share: {
    name = "/mnt/${share}";
    value = {
      device = "${nasIp}:${baseMnt}/${share}";
      fsType = "nfs";
      options = [
        "x-systemd.automount"
        "noauto"
        "rw"
        "vers=4"

        # make Nautilus/Dolphin/Any File Manager show it with a friendly name/icon
        "x-gvfs-show"
        "x-gvfs-name=NAS — ${share}"
        "x-gvfs-icon=network-server"
      ];
    };
  };

  shareConfig = map configureShare shares;
  fsConfig = builtins.listToAttrs shareConfig;

in
{
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  fileSystems = fsConfig;
}
