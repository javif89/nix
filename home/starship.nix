{
  config,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    starship
  ];

  # Starship prompt configuration (equivalent to your starship-prompt.sh)
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;

    # settings = {
    #   # Main prompt format
    #   format = ''
    #     $username$hostname$directory$git_branch$git_status$nodejs$php$go$python$docker_context$nix_shell
    #     $character
    #   '';
    #
    #   # Right side format
    #   right_format = "$cmd_duration$time";
    #
    #   # Character (prompt indicator)
    #   character = {
    #     success_symbol = "[❯](bold green)";
    #     error_symbol = "[❯](bold red)";
    #     vicmd_symbol = "[❮](bold yellow)";
    #   };
    #
    #   # Directory
    #   directory = {
    #     style = "bold cyan";
    #     truncation_length = 3;
    #     truncate_to_repo = false;
    #     format = "[$path]($style)[$lock_symbol]($lock_style) ";
    #   };
    #
    #   # Git branch
    #   git_branch = {
    #     style = "bold purple";
    #     format = "on [$symbol$branch]($style) ";
    #     symbol = " ";
    #   };
    #
    #   # Git status
    #   git_status = {
    #     style = "red";
    #     ahead = "⇡\${count}";
    #     diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
    #     behind = "⇣\${count}";
    #     conflicted = "=";
    #     deleted = "✘";
    #     modified = "!";
    #     renamed = "»";
    #     staged = "+";
    #     stashed = "$";
    #     untracked = "?";
    #     format = "([$all_status$ahead_behind]($style))";
    #   };
    #
    #   # Username
    #   username = {
    #     style_user = "bold yellow";
    #     style_root = "bold red";
    #     format = "[$user]($style) ";
    #     disabled = false;
    #     show_always = false;
    #   };
    #
    #   # Hostname
    #   hostname = {
    #     ssh_only = false;
    #     format = "[@$hostname]($style) ";
    #     style = "bold green";
    #     disabled = true;
    #   };
    #
    #   # Language versions
    #   nodejs = {
    #     style = "bold green";
    #     format = "via [$symbol($version)]($style) ";
    #     symbol = " ";
    #     detect_extensions = ["js" "mjs" "cjs" "ts" "tsx" "vue"];
    #     detect_files = ["package.json" "package-lock.json" "yarn.lock"];
    #   };
    #
    #   php = {
    #     style = "bold blue";
    #     format = "via [$symbol($version)]($style) ";
    #     symbol = " ";
    #     detect_extensions = ["php"];
    #     detect_files = ["composer.json" "composer.lock"];
    #   };
    #
    #   go = {
    #     style = "bold cyan";
    #     format = "via [$symbol($version)]($style) ";
    #     symbol = " ";
    #     detect_extensions = ["go"];
    #     detect_files = ["go.mod" "go.sum"];
    #   };
    #
    #   python = {
    #     style = "bold yellow";
    #     format = "via [$symbol$pyenv_prefix($version)]($style) ";
    #     symbol = " ";
    #     detect_extensions = ["py"];
    #     detect_files = ["requirements.txt" "pyproject.toml" "Pipfile"];
    #   };
    #
    #   # Docker
    #   docker_context = {
    #     style = "blue bold";
    #     format = "via [$symbol$context]($style) ";
    #     symbol = " ";
    #     only_with_files = true;
    #     detect_files = ["docker-compose.yml" "docker-compose.yaml" "Dockerfile"];
    #   };
    #
    #   # Nix shell
    #   nix_shell = {
    #     style = "bold blue";
    #     format = "via [$symbol$state( \\($name\\))]($style) ";
    #     symbol = "❄️ ";
    #     impure_msg = "[impure shell](bold red)";
    #     pure_msg = "[pure shell](bold green)";
    #     unknown_msg = "[unknown shell](bold yellow)";
    #   };
    #
    #   # Command duration
    #   cmd_duration = {
    #     min_time = 2000;
    #     style = "bold yellow";
    #     format = "took [$duration]($style) ";
    #   };
    #
    #   # Time
    #   time = {
    #     disabled = false;
    #     style = "bold white";
    #     format = "[$time]($style)";
    #     time_format = "%T";
    #     utc_time_offset = "local";
    #   };
    #
    #   # Status
    #   status = {
    #     style = "bg:blue";
    #     symbol = "🔴";
    #     format = "[\\[$symbol $common_meaning$signal_name$maybe_int\\]]($style) ";
    #     map_symbol = true;
    #     disabled = false;
    #   };
    #
    #   # Memory usage
    #   memory_usage = {
    #     disabled = false;
    #     threshold = 70;
    #     style = "bold dimmed white";
    #     format = "via $symbol[${ram}( | ${swap})]($style) ";
    #     symbol = " ";
    #   };
    #
    #   # Package version
    #   package = {
    #     disabled = false;
    #     style = "208 bold";
    #     format = "is [$symbol$version]($style) ";
    #     symbol = "📦 ";
    #   };
    #
    #   # AWS
    #   aws = {
    #     style = "bold orange";
    #     format = "on [$symbol($profile)(\\($region\\))(\\[$duration\\])]($style) ";
    #     symbol = "☁️  ";
    #   };
    # };
  };
}
