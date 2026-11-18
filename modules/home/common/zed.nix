{
  pkgs,
  lib,
  ...
}:

{
  programs.zed-editor = {
    enable = true;

    extensions = [
      # Languages
      "nix"
      "toml"
      "rust"
      "go"
      "python"
      "php"
      "blade"
      "laravel-official"
      "svelte"
      "vue"
      "yaml"
      "dockerfile"
      "json"
      "markdown"
      "sql"
      "html"
      "emmet"
      "astro"
      "lua"
      "vue"
      "C#"
      # Themes
      "monokai-pro-ce"
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
      typescript-language-server
      # PHP
      intelephense
    ];

    userSettings = {
      # Vim Settings
      vim_mode = true;
      vertical_scroll_margin = 20;
      ui_font_size = lib.mkForce 18;
      buffer_font_size = lib.mkForce 18;
      # Other
      load_direnv = "shell_hook";
      tab_bar = {
        show = false;
      };

      terminal = {
        dock = "right";
      };

      file_finder = {
        modal_max_width = "full";
      };

      preview_tabs = {
        enabled = true;
        enable_preview_from_file_finder = true;
      };

      project_panel = {
        dock = "right";
      };

      lsp = {
        roslyn.settings = {
          "csharp|completion" = {
            dotnet_show_completion_items_from_unimported_namespaces = true;
          };
        };

        rust-analyzer = {
          binary = {
            path = lib.getExe pkgs.rust-analyzer;
          };
        };

        laravel = {
          initialization_options = {
            phpEnvironment = "local";
          };
        };
      };

      languages = {
        CSharp = {
          language_servers = [
            "roslyn"
            "!omnisharp"
            "!csharp-ls"
          ];
        };

        PHP = {
          language_servers = [
            "intelephense"
            "!phpactor"
          ];
        };

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
  # xdg.configFile."zed/keymap.json".text = builtins.toJSON [
  #   {
  #     context = "Editor && vim_mode == insert && !menu";
  #     bindings = {
  #       "j j" = "vim::NormalBefore";
  #     };
  #   }
  #   {
  #     context = "Editor && mode == full";
  #     bindings = {
  #       "ctrl-~" = null;
  #       "ctrl-shift-`" = "workspace::CloseAllItemsAndPanes";
  #     };
  #   }
  #   {
  #     bindings = {
  #       "ctrl-shift-e" = "project_panel::Toggle";
  #       "shift-escape" = "terminal_panel::Toggle";
  #       "ctrl-shift-0" = "workspace::CloseAllItemsAndPanes";
  #       "ctrl-)" = "workspace::CloseAllItemsAndPanes";
  #     };
  #   }
  #   {
  #     context = "Editor && vim_mode == normal";
  #     bindings = {
  #       "space p" = "command_palette::Toggle";
  #       "ctrl-l" = "workspace::ActivatePaneRight";
  #       "ctrl-h" = "workspace::ActivatePaneLeft";
  #       "g v" = "editor::GoToDefinitionSplit";
  #       "g d" = "editor::GoToDefinition";
  #       "g h" = "editor::ShowSignatureHelp";
  #       "ctrl-k" = "git::Commit";
  #       "ctrl-shift-k" = "git::Push";
  #     };
  #   }
  #   {
  #     context = "!Editor";
  #     bindings = {
  #       "ctrl-shift-o" = "file_finder::Toggle";
  #     };
  #   }
  #   {
  #     context = "!Terminal && (Editor && vim_mode == normal)";
  #     bindings = {
  #       "space o" = "file_finder::Toggle";
  #     };
  #   }
  #   {
  #     context = "Picker";
  #     bindings = {
  #       "alt-n" = "menu::SelectNext";
  #       "alt-p" = "menu::SelectPrevious";
  #     };
  #   }
  # ];
}
