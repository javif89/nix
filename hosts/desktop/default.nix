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
    ../../modules/system/device-management/logitech.nix
    ./hyprland/monitors.nix
    ./hardware-configuration.nix
    ./custom.nix
  ];

  # Mount second hard drive
  boot = {
    supportedFilesystems = [
      "ntfs"
    ];
  };

  networking = {
    # Ensure resolv.conf points to systemd-resolved
    resolvconf.enable = false;
    networkmanager = {
      # Allow DHCP DNS through for homelab purposes
      dns = "systemd-resolved";
    };
  };

  services.resolved = {
    enable = true;
    settings = {
      Resolve = {
        domains = [ ];
        fallbackDns = [ ];
      };
    };
  };

  # -- Nautilus setup --
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  nixpkgs.overlays = [
    (final: prev: {
      nautilus = prev.nautilus.overrideAttrs (nprev: {
        buildInputs =
          nprev.buildInputs
          ++ (with pkgs.gst_all_1; [
            gst-plugins-good
            gst-plugins-bad
          ]);
      });
    })
  ];
  # -- End nautilus setup --

  programs.ssh.extraConfig = "
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
      nautilus
      pkgs.ntfs3g
      obs-studio
    ];
  };
}
