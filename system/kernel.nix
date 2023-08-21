{ config, ... }:
{
  boot.kernel.sysctl = {
    "vm.swappiness" = 0;
  };
}
