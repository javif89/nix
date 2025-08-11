{ lib, ... }:

{
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  fileSystems."/mnt/backups" = {
    device = "10.89.0.15:/mnt/main/backups";
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "noauto"
      "rw"
      "vers=4"

      # make Nautilus show it with a friendly name/icon
      "x-gvfs-show"
      "x-gvfs-name=NAS — backups"
      "x-gvfs-icon=network-server"
    ];
  };
}
# let
#   nasIp = "10.89.0.15";
#   baseMnt = "/mnt/main";
#   shares = [
#     "backups"
#     "container-data"
#     "javi"
#   ];
#   nfsOptions = [
#     "x-systemd.automount"
#     "noauto"
#     "rw"
#     "vers=4"
#   ];
# in
# {
#   fileSystems = lib.genAttrs (map (name: "${baseMnt}/${name}}") shares) (
#     mountPoint:
#     let
#       name = builtins.baseNameOf mountPoint;
#     in
#     {
#       device = "${nasIp}:${baseMnt}/${name}";
#       fsType = "nfs";
#       options = nfsOptions;
#     }
#   );
# }
