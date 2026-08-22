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
    ./hardware-configuration.nix
    ./custom.nix
    ./caddy-local.nix
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
    Include %d/.ssh/homelab_hosts
    Host gitgud.boo
      HostName 10.89.0.82
      User git
      Port 2222
      PubkeyAuthentication yes
      ForwardAgent yes
      IdentitiesOnly yes
      IdentityFile ~/.ssh/id_gitea_key
    Host 10.89.0.3
      IdentitiesOnly yes
      IdentityFile ~/.ssh/brocade_key
      KexAlgorithms +diffie-hellman-group1-sha1
      PubkeyAcceptedKeyTypes=+ssh-rsa
      HostKeyAlgorithms=+ssh-rsa
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

  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      features.cdi = true;
    };
  };
  hardware.nvidia-container-toolkit.enable = true;
  users.users.javi.extraGroups = [ "docker" ];

  # networking.hosts = {
  #   "127.0.0.1" = [
  #     "howtohomelab.fyi"
  #   ];
  # };

  networking.wireguard.interfaces.wg0 = {
    ips = [ "10.101.0.89/24" ];
    privateKeyFile = "/etc/wireguard/homelab.priv";
    peers = [
      {
        publicKey = "SMqLB0joNNqx21PG2VBSPmKKY3XAdwTJLiUnuwbABAA=";
        endpoint = "192.3.63.170:51820";
        allowedIPs = [ "10.101.0.0/24" ];
        persistentKeepalive = 25;
      }
    ];
  };

  programs = {
    nix-ld.enable = true;
    noisetorch.enable = true;
  };

  networking.firewall.checkReversePath = false;
  environment = {
    systemPackages = with pkgs; [
      wireguard-tools
      proton-vpn
      nautilus
      pkgs.ntfs3g
      obs-studio
      kdePackages.kdenlive
      lazydocker
      gparted
    ];
  };

  security = {
    polkit.enable = true;
  };

  networking.extraHosts = ''
    127.0.0.1 static.test
    127.0.0.1 static2.test
  '';
}
