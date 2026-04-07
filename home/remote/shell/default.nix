{ pkgs, ... }:
{
  # Globally enable fish integrations
  home.shell.enableFishIntegration = true;

  programs = {
    # Look up files in the nix store
    nix-index.enable = true;

    # Prompt
    starship = {
      enable = true;
      settings = {
        add_newline = false;
      };
    };

    # Smart history
    atuin.enable = true;

    # Shell
    fish = {
      enable = true;
      functions.notify_long_tasks = {
        onEvent = "fish_postexec";
        body = ''
          if [ "$CMD_DURATION" -gt 5000 ]
            tput bel
          end
        '';
      };

      shellInitLast = ''
        notify_long_tasks
      '';
    };
  };
}
