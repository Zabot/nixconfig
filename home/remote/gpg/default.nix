{ ... }:
{
  # GPG is included in this bundle because we may need to sign
  # things on a remote host. GPG agent is not included, since
  # we would be forwarding the GPG agent from the local host.
  programs.gpg = {
    enable = true;
    mutableKeys = false;
    mutableTrust = false;
    publicKeys = [
      {
        source = ./public_gpg.asc;
        trust = "ultimate";
      }
    ];
  };
}
