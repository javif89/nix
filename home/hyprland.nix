{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Configs
    ./hyprland/binds.nix
    # Ecosystem
    ./hyprland/hyprpaper.nix
    # Desktop environment
    ./hyprland/hyprpanel.nix
    inputs.walker.homeManagerModules.default
  ];

  programs.walker = {
    enable = true;
    runAsService = true;
    config = {
      cache = false;
      websearch = {
        prefix = ":";
      };

      theme = "nixos";
    };
    theme.style = ''
      @define-color selected-text #fabd2f;
      @define-color text #ebdbb2;
      @define-color base #282828;
      @define-color border #ebdbb2;
      @define-color foreground #ebdbb2;
      @define-color background #282828;

      /* Reset all elements */
      #window,
      #box,
      #search,
      #password,
      #input,
      #prompt,
      #clear,
      #typeahead,
      #list,
      child,
      scrollbar,
      slider,
      #item,
      #text,
      #label,
      #sub,
      #activationlabel {
        all: unset;
      }

      * {
        font-family: 'CaskaydiaMono Nerd Font', monospace;
        font-size: 18px;
      }

      /* Window */
      #window {
        background: transparent;
        color: @text;
      }

      /* Main box container */
      #box {
        background: alpha(@base, 0.95);
        padding: 20px;
        border: 2px solid @border;
        border-radius: 0px;
      }

      /* Search container */
      #search {
        background: @base;
        padding: 10px;
        margin-bottom: 0;
      }

      /* Hide prompt icon */
      #prompt {
        opacity: 0;
        min-width: 0;
        margin: 0;
      }

      /* Hide clear button */
      #clear {
        opacity: 0;
        min-width: 0;
      }

      /* Input field */
      #input {
        background: none;
        color: @text;
        padding: 0;
      }

      #input placeholder {
        opacity: 0.5;
        color: @text;
      }

      /* Hide typeahead */
      #typeahead {
        opacity: 0;
      }

      /* List */
      #list {
        background: transparent;
      }

      /* List items */
      child {
        padding: 0px 12px;
        background: transparent;
        border-radius: 0;
      }

      child:selected,
      child:hover {
        background: transparent;
      }

      /* Item layout */
      #item {
        padding: 0;
      }

      #item.active {
        font-style: italic;
      }

      /* Icon */
      #icon {
        margin-right: 10px;
        -gtk-icon-transform: scale(0.7);
      }

      /* Text */
      #text {
        color: @text;
        padding: 14px 0;
      }

      #label {
        font-weight: normal;
      }

      /* Selected state */
      child:selected #text,
      child:selected #label,
      child:hover #text,
      child:hover #label {
        color: @selected-text;
      }

      /* Hide sub text */
      #sub {
        opacity: 0;
        font-size: 0;
        min-height: 0;
      }

      /* Hide activation label */
      #activationlabel {
        opacity: 0;
        min-width: 0;
      }

      /* Scrollbar styling */
      scrollbar {
        opacity: 0;
      }

      /* Hide spinner */
      #spinner {
        opacity: 0;
      }

      /* Hide AI elements */
      #aiScroll,
      #aiList,
      .aiItem {
        opacity: 0;
        min-height: 0;
      }

      /* Bar entry (switcher) */
      #bar {
        opacity: 0;
        min-height: 0;
      }

      .barentry {
        opacity: 0;
      }

    '';
  };

  home.packages = with pkgs; [
    # Running apps
    # wofi

    # Notifications
    libnotify

    # Screenshots
    grim
    slurp
    wl-clipboard
    hyprshot

    # Desktop env
    hyprpanel
  ];

  # Important for certain apps working
  # and dark mode being respected
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  wayland.windowManager.hyprland.enable = true;

  wayland.windowManager.hyprland.settings = {
    input = {
      repeat_delay = 200;
      repeat_rate = 20;
    };

    monitor = [
      "DP-5, 3440x1440@179.99, 0x0, 1"
    ];

    general = {
      layout = "master";
      gaps_out = 0;
      gaps_in = 0;
    };

    workspace = [
      "1, persistent:true"
      "2, persistent:true"
      "3, persistent:true"
      "4, persistent:true"
      "5, persistent:true"
      "6, persistent:true"
    ];

    # Window rules
    windowrulev2 = [
      "opacity 0.85, class:^(Code)$"
    ];

    decoration = {
      blur = {
        enabled = false;
        size = 8;
        passes = 2;
      };

      active_opacity = 1.0;
      inactive_opacity = 1.0;
    };

    exec-once = [
      # "quickshell -c hyprshell"
      "hyprpanel"
    ];
  };

  wayland.windowManager.hyprland.plugins = [
    # inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprbars
  ];

}
