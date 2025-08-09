{
  config,
  pkgs,
  ...
}:
{
  # Bash configuration
  programs.bash = {
    enable = true;
    enableCompletion = true;

    # Shell aliases (equivalent to your script functions)
    shellAliases = {
      sudo = "sudo ";
      # Better ls with eza
      ls = "eza";
      ll = "eza -la";
      la = "eza -la";
      tree = "eza --tree";

      # Convenience
      rp = "source ~/.bashrc";
      co = "code .";

      # Nix
      rb = "sudo nixos-rebuild switch --flake $HOME/nix#default";

      # Git shortcuts
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git pull";
      gco = "git checkout";
      gb = "git branch";
      gd = "git diff";
      glog = "git log --oneline --graph";

      # Directory navigation
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";

      # Development
      a = "php artisan";

      # System
      grep = "rg";

      # System monitoring
      top = "btop";
    };

    # Additional bash configuration
    bashrcExtra = ''
      # Custom functions

      # Project selector function (equivalent to your custom keybinding)
      proj() {
        if [ -d "$HOME/projects" ]; then
          cd "$HOME/projects"
          if command -v eza > /dev/null 2>&1; then
            eza -la
          else
            ls -la
          fi
        else
          echo "Projects directory not found"
        fi
      }

      # Make directory and cd into it
      mkcd() {
        mkdir -p "$1" && cd "$1"
      }


      # Better completion
      bind "set completion-ignore-case on"
      bind "set show-all-if-ambiguous on"
      bind "set show-all-if-unmodified on"

      # Enable color support
      if [ -x /usr/bin/dircolors ]; then
        test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
      fi
    '';
  };
}
