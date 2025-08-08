{
  config,
  pkgs,
  ...
}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;

    # Extensions (commonly used for development)
    extensions = with pkgs.vscode-extensions; [
      # Language support
      ms-vscode.vscode-typescript-next
      bradlc.vscode-tailwindcss
      ms-python.python
      ms-vscode.vscode-json
      redhat.vscode-yaml
      ms-vscode.vscode-css

      # PHP
      bmewburn.vscode-intelephense-client
      xdebug.php-debug

      # Git
      eamodio.gitlens
      mhutchie.git-graph

      # Productivity
      ms-vscode.vscode-eslint
      esbenp.prettier-vscode
      bradlc.vscode-tailwindcss
      formulahendry.auto-rename-tag
      ms-vscode.vscode-color-info

      # Themes and appearance
      pkief.material-icon-theme
      zhuangtongfa.material-theme

      # Docker
      ms-azuretools.vscode-docker

      # Remote development
      ms-vscode-remote.remote-ssh
      ms-vscode-remote.remote-containers

      # Nix support
      bbenoist.nix
      jnoortheen.nix-ide
    ];

    # User settings
    userSettings = {
      # Editor settings
      "editor.fontSize" = 14;
      "editor.fontFamily" = "'FiraCode Nerd Font', 'Droid Sans Mono', monospace";
      "editor.fontLigatures" = true;
      "editor.tabSize" = 2;
      "editor.insertSpaces" = true;
      "editor.wordWrap" = "on";
      "editor.minimap.enabled" = false;
      "editor.renderWhitespace" = "boundary";
      "editor.rulers" = [80 120];
      "editor.formatOnSave" = true;
      "editor.codeActionsOnSave" = {
        "source.fixAll.eslint" = "explicit";
        "source.organizeImports" = "explicit";
      };

      # Workbench
      "workbench.colorTheme" = "Material Theme Darker High Contrast";
      "workbench.iconTheme" = "material-icon-theme";
      "workbench.startupEditor" = "newUntitledFile";
      "workbench.sideBar.location" = "left";

      # Files
      "files.autoSave" = "onFocusChange";
      "files.trimTrailingWhitespace" = true;
      "files.insertFinalNewline" = true;
      "files.exclude" = {
        "**/node_modules" = true;
        "**/vendor" = true;
        "**/.git" = true;
        "**/.svn" = true;
        "**/.hg" = true;
        "**/CVS" = true;
        "**/.DS_Store" = true;
        "**/Thumbs.db" = true;
      };

      # Terminal
      "terminal.integrated.fontFamily" = "'FiraCode Nerd Font'";
      "terminal.integrated.fontSize" = 13;
      "terminal.integrated.shell.linux" = "${pkgs.bash}/bin/bash";

      # Git
      "git.enableSmartCommit" = true;
      "git.autofetch" = true;
      "git.confirmSync" = false;

      # Language-specific settings
      "[javascript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[typescript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[json]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[html]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[css]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[php]" = {
        "editor.defaultFormatter" = "bmewburn.vscode-intelephense-client";
      };
      "[nix]" = {
        "editor.defaultFormatter" = "jnoortheen.nix-ide";
        "editor.tabSize" = 2;
      };

      # PHP Intelephense
      "intelephense.files.maxSize" = 5000000;
      "intelephense.telemetry.enabled" = false;

      # ESLint
      "eslint.validate" = [
        "javascript"
        "javascriptreact"
        "typescript"
        "typescriptreact"
        "vue"
      ];

      # Prettier
      "prettier.singleQuote" = true;
      "prettier.trailingComma" = "es5";
      "prettier.tabWidth" = 2;
      "prettier.semi" = true;

      # Docker
      "docker.showStartPage" = false;

      # Telemetry
      "telemetry.telemetryLevel" = "off";
      "extensions.ignoreRecommendations" = true;

      # Security
      "security.workspace.trust.enabled" = false;

      # Window
      "window.titleBarStyle" = "custom";
      "window.menuBarVisibility" = "toggle";
    };

    # Keybindings
    keybindings = [
      {
        key = "ctrl+shift+p";
        command = "workbench.action.showCommands";
      }
      {
        key = "ctrl+p";
        command = "workbench.action.quickOpen";
      }
      {
        key = "ctrl+shift+n";
        command = "workbench.action.files.newUntitledFile";
      }
      {
        key = "ctrl+shift+f";
        command = "workbench.action.findInFiles";
      }
      {
        key = "ctrl+`";
        command = "workbench.action.terminal.toggleTerminal";
      }
    ];
  };
}
