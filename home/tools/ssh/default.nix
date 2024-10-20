{ config, ... }:
{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        user = "git";
        extraOptions = {
          UserKnownHostsFile = "${./known_hosts/github.known_hosts}";
        };
      };
    };
  };
}
