{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.newsboat = {
    enable = true;
    urls = [
      {
        title = "LWN";
        url = "https://lwn.net/headlines/rss";
      }
      {
        title = "Kagi Blog";
        url = "https://blog.kagi.com/rss.xml";
      }
      {
        title = "Fastmail Blog";
        url = "https://www.fastmail.com/blog/feed.xml";
      }
      {
        title = "NixOS Blog";
        url = "https://nixos.org/blog/announcements-rss.xml";
      }
      {
        title = "404 Media";
        url = "https://www.404media.co/rss";
      }
    ];
  };
}
