{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;

      # A minimal left prompt
      format = "$python$directory$character";

      # move the rest of the prompt to the right
      right_format = "$status$git_branch$git_status";

      character = {
        success_symbol = "[❯](red)[❯](yellow)[❯](green)";
        error_symbol = "[❯](red)[❯](yellow)[❯](green)";
        vicmd_symbol = "[❮](green)[❮](yellow)[❮](red)";
      };

      git_branch = {
        format = "[$branch]($style) ";
        style = "bold green";
      };

      python = {
        format = "[(\\($virtualenv\\) )]($style)";
        style = "white";
      };

      git_status = {
        format = "$all_status$ahead_behind ";
        ahead = "[⬆](bold purple) ";
        behind = "[⬇](bold purple) ";
        staged = "[✚](green) ";
        deleted = "[✖](red) ";
        renamed = "[➜](purple) ";
        stashed = "[✭](cyan) ";
        untracked = "[◼](white) ";
        modified = "[✱](blue) ";
        conflicted = "[═](yellow) ";
        diverged = "⇕ ";
        up_to_date = "";
      };

      directory = {
        style = "blue";
        truncation_length = 1;
        truncation_symbol = "";
        fish_style_pwd_dir_length = 1;
      };

      cmd_duration = {
        format = "[$duration]($style) ";
      };

      line_break = {
        disabled = true;
      };

      status = {
        disabled = false;
        symbol = "✘ ";
      };
    };
  };
}
