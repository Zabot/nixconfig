{ config, pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    profiles.zach = {
      name = "zach";
      isDefault = true;

      userChrome = builtins.readFile ./userChrome.css;
      settings = {
        "app.normandy.enabled" = false;

        # Don't show welcome screen on first boot
        "browser.aboutwelcome.enabled" = false;

        # Don't show anything on the new tab page
        "browser.newtabpage.activity-stream.discoverystream.spocs.startupCache.enabled" = false;
        "browser.newtabpage.activity-stream.discoverystream.thumbsUpDown.region-thumbs-config" = "US";
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.topsites" = false;

        # Use dark theme
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";

        # Enable userChrome.css
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };

      search = {
        force = true;
        default = "Jackrabbit";
        engines = {
          # Setup Jackrabbit
          Jackrabbit = let server = "http://localhost:8080"; in {
            iconUpdateURL = "${server}/jackrabbit.png";
            urls = [{
              template = "${server}/search?q={searchTerms}";
            }];
          };

          # Hide everything else
          "Google".metaData.hidden = true;
          "Amazon.com".metaData.hidden = true;
          "Bing".metaData.hidden = true;
          "DuckDuckGo".metaData.hidden = true;
          "eBay".metaData.hidden = true;
          "Wikipedia (en)".metaData.hidden = true;
        };
      };

      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        tree-style-tab
      ];
    };
  };
}
