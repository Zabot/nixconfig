{ ... }:
{
  imports = [
    ./module.nix
  ];

  services.jackrabbit = {
    enable = true;
    bookmarks = {
      g = "https://duckduckgo.com/?q={}";
      nix = "https://search.nixos.org/packages?query={}";
      go = "https://pkg.go.dev/search?q={}";
      rust = "https://docs.rs/releases/search?query={}";
      std = "https://www.cplusplus.com/search.do?q={}";
    };
  };
}

