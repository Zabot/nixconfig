{ config, lib, pkgs, system, ... }:
{
  programs.git = {
    enable = true;
    userEmail = system.global.user.email;
    userName = system.global.user.name;

    aliases = {
      sl = "!git --no-pager log --graph --decorate --oneline --exclude='refs/notes/*' --all -20";
      b = "for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:short)%(color:reset))'";
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
      notes.rewriteRef = [
        "refs/notes/fel"
      ];
    };
  };
}
