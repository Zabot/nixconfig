{ pkgs, nur-pkgs, system, config, ... }:
{
  programs.firefox = {
    enable = true;
    profiles.zach = {
      name = "zach";
      isDefault = true;

      userChrome = pkgs.replaceVars ./userChrome.css {
        background = system.colors.background;
        background-hl = system.colors.background-hl;
        foreground = system.colors.foreground;
        accent = system.colors.focus;
      };
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

        # Disable AI junk
        "browser.ml.enable" = false;
        "browser.ml.chat.enabled" = false;
        "browser.ml.chat.menu" = false;
        "browser.ml.chat.page" = false;
        "extensions.ml.enabled" = false;
        "browser.ml.linkPreview.enabled" = false;
        "browser.tabs.groups.smart.enabled" = false;
        "browser.tabs.groups.smart.userEnabled" = false;

        "browser.toolbars.bookmars.visibility" = "never";
        "sidebar.verticalTabs" = true;
      };

      search = {
        force = true;
        default = "Jackrabbit";
        engines = {
          # Setup Jackrabbit
          Jackrabbit = let server = "http://${config.services.jackrabbit.interface}"; in {
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

      extensions.packages = with nur-pkgs.repos.rycee.firefox-addons; [
        ublock-origin
        #tree-style-tab
      ];
    };
  };
}
