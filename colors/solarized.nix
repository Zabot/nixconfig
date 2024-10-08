let
# Solarized defines a single palette that includes dark and light colors
solarized = {
  base03  = "#002b36";
  base02  = "#073642";
  base01  = "#586e75";
  base00  = "#657b83";
  base0   = "#839496";
  base1   = "#93a1a1";
  base2   = "#eee8d5";
  base3   = "#fdf6e3";

  red     = "#dc322f";
  green   = "#859900";
  blue    = "#268bd2";
  cyan    = "#2aa198";
  magenta = "#d33682";
  yellow  = "#b58900";
  violet  = "#6c71c4";
  orange  = "#cb4b16";
};

# Solarized has a canonical mapping of colors onto terminal colors
termcolors = {
  normal = {
    black =   solarized.base02;
    white =   solarized.base2;
    yellow =  solarized.yellow;
    red =     solarized.red;
    magenta = solarized.magenta;
    blue =    solarized.blue;
    cyan =    solarized.cyan;
    green =   solarized.green;
  };

  bright = {
    black =   solarized.base00;
    green =   solarized.base01;
    yellow =  solarized.base00;
    blue =    solarized.base0;
    cyan =    solarized.base1;
    white =   solarized.base3;
    red =     solarized.orange;
    magenta = solarized.violet;
  };
};

common = {
  urgent = solarized.red;
  notice = solarized.red;
  error = solarized.red;
  warn = solarized.yellow;
  ok = solarized.green;

  focus = solarized.yellow;
  focus-accent = solarized.orange;

  inherit termcolors;
};
in {
  dark = {
    background    = solarized.base03;
    background-hl = solarized.base02;
    secondary     = solarized.base01;
    foreground    = solarized.base0;
    emph          = solarized.base1;
  } // common;

  light = {
    background    = solarized.base3;
    background-hl = solarized.base2;
    secondary     = solarized.base1;
    foreground    = solarized.base00;
    emph          = solarized.base01;
  } // common;
}
