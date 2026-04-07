{
  system,
  ...
}:
{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = system.global.user.name;
        email = system.global.user.email;
      };

      alias = {
        sl = "!git --no-pager log --graph --decorate --oneline --exclude='refs/notes/*' --all -20";
        b = "for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:short)%(color:reset))'";
      };

      pull = {
        rebase = false;
        ff = "only";
      };

      init.defaultBranch = "master";
      advice.detachedHead = false;
      notes.rewriteRef = [ "refs/notes/fel" ];
      push.default = "matching";

      gpg.format = "ssh";
      commit.gpgsign = true;
      user.signingKey = "~/.ssh/id_ed25519_sk.pub";
    };
  };
}
