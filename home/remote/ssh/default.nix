{ config, ... }:
{
  programs.ssh = {
    enableDefaultConfig = false;
    enable = true;
    matchBlocks = {
      # Hardcode github key
      "github.com" = {
        user = "git";
        extraOptions = {
          UserKnownHostsFile = "${./known_hosts/github.known_hosts}";
        };
      };

      "*" = {
        forwardAgent = false;
        addKeysToAgent = "no";
        compression = false;
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        hashKnownHosts = false;
        userKnownHostsFile = "~/.ssh/known_hosts";
        controlMaster = "no";
        controlPath = "~/.ssh/master-%r@%n:%p";
        controlPersist = "no";
      };
    };
  };
}
