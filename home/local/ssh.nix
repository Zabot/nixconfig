{
  pkgs,
  lib,
  ...
}:
let
  tpm_keydir = "%h/.ssh/tpm";
in
{
  services.ssh-agent = {
    enable = false;
    socket = "ssh-agent-base";
  };

  # https://github.com/Foxboron/ssh-tpm-agent/blob/master/contrib/services/system/ssh-tpm-genkeys.service
  systemd.user.services.ssh-tpm-genkeys = {
    Unit = {
      Description = "SSH TPM Key Generation";
      ConditionPathExists = [
        "|!/${tpm_keydir}/ssh_tpm_host_ecdsa_key.pub"
        "|!/${tpm_keydir}/ssh_tpm_host_ecdsa_key.tpm"
        "|!/${tpm_keydir}/ssh_tpm_host_rsa_key.pub"
        "|!/${tpm_keydir}/ssh_tpm_host_rsa_key.tpm"
      ];
    };
    Service =
      let
        tmpdir = "%T/ssh-tpm";
      in
      {
        ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p ${tmpdir}/etc/ssh";
        ExecStart = "${pkgs.ssh-tpm-agent}/bin/ssh-tpm-keygen -A -f ${tmpdir}";
        ExecStartPost = "${pkgs.coreutils}/bin/mv ${tmpdir}/etc/ssh ${tpm_keydir}";
        Type = "oneshot";
        RemainAfterExit = "yes";
      };
  };

  # https://github.com/Foxboron/ssh-tpm-agent/blob/master/contrib/services/system/ssh-tpm-agent.service
  systemd.user.services.ssh-tpm-agent = {
    Unit = {
      ConditionEnvironment = "!SSH_AGENT_PID";
      Description = "ssh-tpm-agent service";
      Documentation = [
        "man:ssh-agent(1)"
        "man:ssh-add(1)"
        "man:ssh(1)"
      ];
      Wants = [ "ssh-tpm-genkeys.service" ];
      After = [
        "ssh-tpm-genkeys.service"
        "ssh-yk-agent.service"
      ];
    };
    Install.WantedBy = [ "default.target" ];
    Service = {
      ExecStart = "${pkgs.ssh-tpm-agent}/bin/ssh-tpm-agent --key-dir ${tpm_keydir} -A %t/yubikey-agent.sock";
      PassEnvironment = "SSH_AGENT_PID";
      KillMode = "process";
      Restart = "always";
    };
  };

  # https://github.com/FiloSottile/yubikey-agent/blob/main/contrib/systemd/user/yubikey-agent.service
  systemd.user.services.ssh-yk-agent = {
    Unit = {
      Description = "Seamless ssh-agent for YubiKeys";
      Documentation = "https://filippo.io/yubikey-agent";
    };

    # This whole thing could probably be replaced with the native FIDO
    # support in vanilla ssh agent.
    Service = {
      Environment = [
        "PATH=${
          lib.makeBinPath [
            # Support for using pinentry-tty isn't great.
            # https://github.com/FiloSottile/yubikey-agent/issues/92
            pkgs.pinentry-gtk2
          ]
        }"
      ];
      ExecStart = "${pkgs.yubikey-agent}/bin/yubikey-agent -l %t/yubikey-agent.sock";
      ExecReload = "/bin/kill -HUP $MAINPID";
      IPAddressDeny = "any";
      RestrictAddressFamilies = "AF_UNIX";
      RestrictNamespaces = "yes";
      RestrictRealtime = "yes";
      RestrictSUIDSGID = "yes";
      LockPersonality = "yes";
      SystemCallFilter = [
        "@system-service"
        "~@privileged @resources"
      ];
      SystemCallErrorNumber = "EPERM";
      SystemCallArchitectures = "native";
      NoNewPrivileges = "yes";
      KeyringMode = "private";
      UMask = "0177";
      RuntimeDirectory = "yubikey-agent";
    };

    Install.WantedBy = [ "default.target" ];
  };

  # Set the ssh agent sock
  sshAuthSock = {
    initialization =
      let
        socketPath = "$XDG_RUNTIME_DIR/ssh-tpm-agent.sock";
      in
      {
        bash = ''export SSH_AUTH_SOCK="${socketPath}"'';
        fish = ''set -x SSH_AUTH_SOCK "${socketPath}"'';
        nushell = ''$"($env.XDG_RUNTIME_DIR)/ssh-tpm-agent.sock"'';
      };
  };
}
