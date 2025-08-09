{ config, pkgs, ... }:

{
  # Enable SSH client and add to agent automatically
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };

  # Per-user ssh-agent (systemd --user)
  services.ssh-agent.enable = true;

  # Systemd unit to load all private keys from ~/.ssh
  systemd.user.services."ssh-add-all-keys" = {
    Unit = {
      Description = "Add all SSH keys from ~/.ssh to ssh-agent";
      After = [ "ssh-agent.service" ];
      Requires = [ "ssh-agent.service" ];
    };
    Service = {
      Type = "oneshot";
      Environment = [ "SSH_ASKPASS_REQUIRE=prefer" ];
      ExecStart = ''
        ${pkgs.openssh}/bin/ssh-add -q ~/.ssh/id_* 2>/dev/null || true
      '';
    };
    Install.WantedBy = [ "default.target" ];
  };
}
