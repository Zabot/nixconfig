{ pkgs, inputs, config, ... }:
let
  firefoxCSS = pkgs.fetchFromGitHub {
    owner = "MrOtherGuy";
    repo = "firefox-csshacks";
    rev = "875a83e8b83f8fdb273a8b21c0d6f558f9019eae";
    hash = "sha256-iFXjGtsyF840uFGbWgc4qnBOy+4dEIF2sIuJ3x7fMKw=";
  };

  chromeTheme = with config.colors; {
    lwt-accent-color = background;
    lwt-accent-color-inactive = background;
    lwt-tab-line-color = foreground;
    lwt-text-color = foreground;

    toolbar-bgcolor = background;
    toolbar-color = foreground;

    tab-selected-textcolor = foreground;
    tab-selected-bgcolor = background-hl;
    tab-selected-outline-color = focus;
    tab-border-radius = 0;
    tab-block-margin = "1px";

    border-radius-medium = 0;

    toolbarbutton-icon-fill = foreground;
    toolbarbutton-border-radius = 0;
    toolbar-field-border-color = background-hl;
    toolbar-field-background-color = background;
    toolbar-field-focus-background-color = background-hl;

    urlbarView-highlight-background = background-hl;
    urlbarView-highlight-color = foreground;

    tabpanel-background-color = background;
    tabpanel-border-color = background-hl;

    color-accent-primary = focus;
    arrow-panel-border-color = focus;
    toolbar-field-focus-border-color = focus;
  };

  contentTheme = with config.colors; {
    newtab-background-color = background;
    newtab-background-color-secondary = background-hl;
    newtab-background-card = focus;
    newtab-text-primary-color = foreground;
  };

  # Turn a list of paths into a series of css include statements
  useCSS = files: builtins.concatStringsSep "\n" (builtins.map (f: "@import url(${f});") files);

  # Turn a attrset into a series of css property definitions
  toCSS = attrs: (
    builtins.concatStringsSep "\n" (
      builtins.attrValues (
        builtins.mapAttrs (k: v: "--${k}: ${builtins.toString v} !important;") attrs
      )
    )
  );
in {
  programs.firefox = {
    enable = true;
    profiles.zach = {
      name = "zach";
      isDefault = true;

      userChrome = useCSS [
        "${firefoxCSS}/chrome/toolbars_below_content_v2.css"
        "${firefoxCSS}/chrome/urlbar_connection_type_background_colors.css"
        "${firefoxCSS}/chrome/urlbar_container_color_border.css"
        ./tweaks.css

        (pkgs.writeText "theme.css" ":root { ${toCSS chromeTheme} }" )
      ];

      userContent = useCSS [
        # Give transparent images a checkerboard background
        "${firefoxCSS}/content/standalone_image_page_mods.css"
        (pkgs.writeText "theme.css" ":root { ${toCSS contentTheme} }" )
      ];

      settings = {
        # Handful of privacy settings from https://wiki.archlinux.org/title/Firefox/Privacy
        "privacy.donottrackheader.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.resistFingerprinting" = false;
        "privacy.fingerprintingProtection" = true;
        "privacy.fingerprintingProtection.overrides" = "+AllTargets,-CSSPrefersColorScheme";
        "media.peerconnection.ice.default_address_only" = true;
        "toolkit.telemetry.enabled" = false;
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

        # Hide the bookmark toolbar
        "browser.toolbars.bookmarks.visibility" = "never";

        # Vertical tabs
        "sidebar.verticalTabs" = true;
        "sidebar.visibility" = "expand-on-hover";
        "sidebar.animation.enabled" = false;

        # Don't use builtin password manager
        "signon.rememberSignons" = false;
        "signon.autofillForms" = false;

        # Make sure we're using hardware acceleration
        "gfx.webrender.all" = true;
        "gfx.webrender.software" = false;
        "media.hardware-video-decoding.enabled" = true;
        "media.hardware-video-decoding.force-enabled" = true;

        # Enable my tab hoarding tendencies
        "browser.tabs.unloadOnLowMemory" = true;
        "browser.low_commit_space_threshold_percent" = 100;
        "browser.tabs.min_inactive_duration_before_unload" = 10 * 60 * 1000;

        # No DRM content
        "browser.eme.ui.enabled" = false;
        "media.eme.enabled" = false;
      };

      search = {
        force = true;
        default = "Jackrabbit";
        engines = {
          # Setup Jackrabbit
          Jackrabbit = let server = "http://${config.services.jackrabbit.interface}"; in {
            icon = "${server}/jackrabbit.png";
            urls = [{
              template = "${server}/search?q={searchTerms}";
            }];
          };

          # Hide everything else
          "google".metaData.hidden = true;
          "bing".metaData.hidden = true;
          "wikipedia".metaData.hidden = true;
          "ebay".metaData.hidden = true;
          "ddg".metaData.hidden = true;
          "amazondotcom-us".metaData.hidden = true;
        };
      };

      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        bitwarden
      ];
    };
  };
}
