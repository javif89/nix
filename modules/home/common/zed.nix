{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  programs.zed-editor = {
    enable = true;

    # Zed “extensions” (smaller set than VSCode)
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
      nixd
      rust-analyzer
      gopls
      pyright
      nodePackages_latest.typescript-language-server
      zls
      phpactor
    ];
  };
}
