{ config, lib, pkgs, system, ... }:
{
  programs.git = {
    enable = true;
    userEmail = system.global.user.email;
    userName = system.global.user.name;

    aliases = {
      sl = "!git --no-pager log --graph --decorate --oneline --all -20";
    };

    extraConfig = {
      push.default = "matching";
      pull = {
        rebase = false;
        ff = "only";
      };
      init.defaultBranch = "master";
      advice.detachedHead = false;
    };
  };
}
