{ config, pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    profiles.zach = {
      name = "zach";
      isDefault = true;

      userChrome = builtins.readFile ./userChrome.css
    };
  };
}
