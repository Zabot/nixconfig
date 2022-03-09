{ config, lib, pkgs, ... }:
{
  programs.git = {
    enable = true;
	  userEmail = "zach.inbox@gmail.com";
	  userName = "Zach Anderson";

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
