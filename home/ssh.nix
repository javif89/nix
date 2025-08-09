{ config, pkgs, ... }:

{
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };

  services.ssh-agent.enable = true;

  systemd.user.services."ssh-add-all-keys" = {
    Unit = {
      Description = "Add all SSH keys from ~/.ssh to ssh-agent";
      After = [ "ssh-agent.service" ];
      Requires = [ "ssh-agent.service" ];
      # Skip running if there are no id_* keys:
      ConditionPathExistsGlob = "%h/.ssh/id_*";
    };
    Service = {
      Type = "oneshot";
      ExecStart = ''
        ${pkgs.bash}/bin/bash -lc '${pkgs.openssh}/bin/ssh-add -q %h/.ssh/id_* 2>/dev/null || true'
      '';
      # Make it non-interactive (don’t pop up askpass):
      Environment = [
        "SSH_ASKPASS=/bin/false"
        "DISPLAY=ignored"
      ];
    };
    Install.WantedBy = [ "default.target" ];
  };
}
