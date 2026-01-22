{
  pkgs,
  lib,
  ...
}:

{
  programs.zed-editor = {
    enable = true;

    extensions = [
      "nix"
      "toml"
      "rust"
      "go"
      "python"
      "php"
      "svelte"
      "vue"
      "yaml"
      "dockerfile"
      "json"
      "markdown"
    ];

    # LSP / tools (instead of VSCode extensions)
    extraPackages = with pkgs; [
      # Nix language support
      nixd
      nil
      # Rust
      rust-analyzer
      # Go
      gopls
      # Python
      pyright
      # Nodejs
      nodePackages_latest.typescript-language-server
      # PHP
      phpactor
    ];

    userSettings = {
      # Vim Settings
      vim_mode = true;
      vertical_scroll_margin = 20;
      # Other
      load_direnv = "shell_hook";
      tab_bar = {
        show = false;
      };

      file_finder = {
      };

      project_panel = {
        dock = "right";
      };

      lsp = {
        rust-analyzer = {
          binary = {
            path = lib.getExe pkgs.rust-analyzer;
          };
        };
      };

      languages = {
        Nix = {
          language_servers = [ "nixd" ];
          formatter = {
            external = {
              command = "nixfmt";
            };
          };
        };
      };
    };
  };

  # Doing the keymap like this since previously the HM module
  # was trying to get cute and "merge" the configs, which
  # just caused it to keep old keybindings even if
  # I removed them.
  xdg.configFile."zed/keymap.json".text = builtins.toJSON [
    {
      context = "Editor && vim_mode == insert && !menu";
      bindings = {
        "j j" = "vim::NormalBefore";
      };
    }
    {
      context = "Editor && vim_mode == normal";
      bindings = {
        "space p" = "command_palette::Toggle";
        "ctrl-l" = "workspace::ActivatePaneRight";
        "ctrl-h" = "workspace::ActivatePaneLeft";
        "g v" = "editor::GoToDefinitionSplit";
        "g d" = "editor::GoToDefinition";
        "g h" = "editor::ShowSignatureHelp";
        "ctrl-k" = "git::Commit";
        "ctrl-shift-k" = "git::Push";
      };
    }
    {
      context = "!Editor";
      bindings = {
        "ctrl-shift-o" = "file_finder::Toggle";
      };
    }
    {
      context = "!Terminal && (Editor && vim_mode == normal)";
      bindings = {
        "space o" = "file_finder::Toggle";
      };
    }
    {
      bindings = {
        "ctrl-shift-e" = "workspace::ToggleRightDock";
        "shift-escape" = "terminal_panel::Toggle";
        "ctrl-shift-0" = "workspace::CloseAllItemsAndPanes";
        "ctrl-)" = "workspace::CloseAllItemsAndPanes";
        "ctrl-shift-~" = null;
      };
    }
    {
      context = "Picker";
      bindings = {
        "alt-n" = "menu::SelectNext";
        "alt-p" = "menu::SelectPrevious";
      };
    }
  ];
}
