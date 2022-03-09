{ config, lib, pkgs, ... }:
{
  programs.nix-index.enable = true;
  programs.nix-index.enableZshIntegration = true;

  programs.zsh = {

		plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.4.0";
          sha256 = "037wz9fqmx0ngcwl9az55fgkipb745rymznxnssr3rx9irb6apzg";
        };
      }
    ];

    enable = true;
    enableAutosuggestions = false;
    enableCompletion = false;
    prezto = {
      enable = true;
      autosuggestions.color = "fg=red";
      caseSensitive = false;

      pmodules = [
        "environment"
        "terminal"
        "history"
        "editor"
        "directory"
        "spectrum"
        "utility"
        "prompt"

        "history-substring-search"
        "autosuggestions"
        "completion"
        "fasd"
        "git"
      ];
      prompt.theme = "agnoster";
    };

    history = {
      ignoreSpace = true;
      save = 10000;
      size = 10000;
      share = false;
    };
  };

}
