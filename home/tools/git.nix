{ config, lib, pkgs, system, ... }:
{
  programs.git = {
    enable = true;
    userEmail = system.global.user.email;
    userName = system.global.user.name;

    aliases = {
      sl = "!git --no-pager log --graph --decorate --oneline --all -20";
    };

    signing.signByDefault = true;
    signing.key = null;

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
