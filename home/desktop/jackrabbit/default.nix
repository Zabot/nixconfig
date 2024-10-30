{ ... }:
{
  imports = [ ./module.nix ];

  services.jackrabbit = {
    enable = true;
    default = "https://kagi.com/search?q={}";
    bookmarks = {
      g = "https://kagi.com/search?q={}";
      gpt = "https://kagi.com/fastgpt?query={}";
      nix = "https://search.nixos.org/packages?query={}";
      go = "https://pkg.go.dev/search?q={}";
      cargo = "https://docs.rs/releases/search?query={}";
      std = "https://www.cplusplus.com/search.do?q={}";
    };
  };
}
