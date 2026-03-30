{
  system,
  ...
}:
{
  programs.git = {
    enable = true;

    signing.signByDefault = false;
    signing.key = null;

    settings = {
      user = {
        name = system.global.user.email;
        email = system.global.user.name;
      };

      aliases = {
        sl = "!git --no-pager log --graph --decorate --oneline --exclude='refs/notes/*' --all -20";
        b = "for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:short)%(color:reset))'";
      };

      extraConfig = {
        push.default = "matching";
        pull = {
          rebase = false;
          ff = "only";
        };
        init.defaultBranch = "master";
        advice.detachedHead = false;
        notes.rewriteRef = [ "refs/notes/fel" ];
      };
    };
  };
}
