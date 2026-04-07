{ config, pkgs, lib, ... }:
{
  programs.vim = {
    enable = true;
    package = pkgs.vim;
    defaultEditor = true;
  };

  virtualisation.docker.enable = true;
  hardware.keyboard.zsa.enable = true;

  services = {
    # Auto login on the first TTY since we have FDE
    getty = {
      autologinUser = config.global.user.unixname;
      autologinOnce = true;
    };

    # TODO Get kmscon working
    kmscon = lib.mkIf false {
      enable = true;
      hwRender = true;
      fonts = [
        {
          name = "Iosevka Nerd Font Mono";
          package = pkgs.nerd-fonts.iosevka;
        }
      ];
      extraConfig = builtins.concatStringsSep "\n" [
        "font-size=18"
        "palette=solarized"
      ];
      autologinUser = config.global.user.unixname;
    };

    # Framework deep sleep doesn't work very well, just hibernate instead
    logind.settings.Login.HandleLidSwitch = "hibernate";

    printing.enable = true;

    # Upower provides dbus hooks for power info (device battery level, peripheral battery level, etc)
    upower.enable = true;

    # Pipewire is the latest and greatest for sound
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;

      # Enable support for streaming audio to raop output devices
      raopOpenFirewall = true;
      extraConfig.pipewire = {
        "10-airplay" = {
          "context.modules" = [
            {
              name = "libpipewire-module-raop-discover";

              # increase the buffer size if you get dropouts/glitches
              # args = {
              #   "raop.latency.ms" = 500;
              # };
            }
          ];
        };
      };
    };
    avahi.enable = true;
  };

  hardware = {
    # Enable backlight brightness control from userspace
    acpilight.enable = true;
  };

  boot.kernelParams = [ "amd_pstate=passive" ];
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
    powertop.enable = true;
  };
}
