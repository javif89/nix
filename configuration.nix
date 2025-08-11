{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./system/nvidia.nix
    ./system/de/gdm.nix
    ./system/de/hypr/hyprland.nix
    ./system/nfs.nix
    ./system/fonts.nix
    inputs.home-manager.nixosModules.default
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Flatpak (Basically just for discord)
  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.javi = {
    isNormalUser = true;
    description = "javi";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    brave
    neovim
    git
    openssh
    pkgs.ntfs3g
    xdg-user-dirs-gtk # This helps with Nautilus integration
  ];

  services.openssh = {
    enable = true;
  };

  programs.ssh = {
    startAgent = true;
    extraConfig = "
      Host myhost
        Hostname gitgud.foo 
    ";
  };

  system.stateVersion = "25.05"; # Did you read the comment?

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Mount my second drive
  boot.supportedFilesystems = [ "ntfs" ];
  fileSystems."/mnt/working-files" = {
    device = "/dev/disk/by-uuid/BE8EBBDA8EBB8A03";
    fsType = "ntfs";
    options = [
      "uid=1000" # your user ID (check with `id -u`)
      "gid=100" # your primary group ID (check with `id -g`)
      "dmask=022" # dir permissions
      "fmask=133" # file permissions
      "nofail"

      # make Nautilus show it with a friendly name/icon
      "x-gvfs-show"
      "x-gvfs-name=Working Files"
    ];
  };

  # Theme
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark.yaml";
    # image = "/home/javi/Documents/wallpapers/Fantasy-Mountain.png";
    polarity = "dark";
  };

  # Enable home manager
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "javi" = {
        imports = [
          inputs.hyprshell.homeManagerModules.default
          ./home.nix
        ];
      };
    };
  };
}
