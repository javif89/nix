{
  config,
  pkgs,
  ...
}:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    dotDir = config.home.homeDirectory;

    # Shell aliases (equivalent to your script functions)
    shellAliases = {
      sudo = "sudo ";
      # Nix
      rb = "git add . && sudo nixos-rebuild switch --flake $HOME/nix#desktop";
      rbl = "git add . && sudo nixos-rebuild switch --flake $HOME/nix#laptop";

      eza = "eza";
      ls = "eza -lh --group-directories-first --icons=always";
      cat = "bat";
      bat = "bat";

      # Quicker navigation
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";

      # Git
      gs = "git status";
      ga = "git add -A";
      gc = "git commit -m";
      grm = "git rm $(git ls-files --deleted)";
      gb = "git checkout -b";

      # Docker aliases
      dc = "docker-compose";
      bx = "docker buildx";
      de = "docker exec -it";
      dub = "docker compose up -d --build";
      dup = "docker-compose up";
      dwn = "docker-compose down";
      da = "docker_artisan";

      # Laravel & php
      a = "php artisan";

      # Convenience
      cls = "clear";
      home = "cd ~";
      projects = "cd ~/projects";
      co = "code .";
      clipboard = "wl-copy";

      # Jigsaw
      jig = "vendor/bin/jigsaw";

      # Golang
      gr = "go run .";
      gmt = "go mod tidy";
    };

    # Additional bash configuration
    initContent = ''
      function nixgc() {
        nix-collect-garbage -d --delete-older-than 5d
        sudo nix-collect-garbage -d --delete-older-than 5d
        nix store optimise
      }

      function newsshkey() {
        KEY_NAME="id_ed25519_$1"
        KEY_PATH="$HOME/.ssh/$KEY_NAME"
        ssh-keygen -t ed25519 -C "$1" -f "$KEY_PATH" -N ""
        ssh-add "$KEY_PATH"
        echo "Key created and added"
        echo "Key: $KEY_NAME"
        echo "Saved to: $KEY_PATH"
      }

      function listsshkeys() {
        ls "$HOME/.ssh"
      }

      function copypublickey() {
        KEY_NAME="$1"
        KEY_PATH="$HOME/.ssh/$KEY_NAME"
        cat "$KEY_PATH.pub" | clipboard
        echo "Key copied to clipboard"
      }
    '';
  };

  home.sessionPath = [
    "$HOME/.config/composer/vendor/bin"
    "$HOME/.fly/bin"
    "$HOME/.cargo/bin"
  ];
}
