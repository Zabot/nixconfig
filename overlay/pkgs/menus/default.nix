{ substituteAll
, writeShellScriptBin
, rofi
}:

{ options
, colors
, prompt ? ""
, width ? 11
}:
let
  print_option = {label, icon, command}:
    ''echo -en "${label}\0icon\x1f${icon}\x1finfo\x1f${label}\n"'';
  print_action = {label, icon, command}: ''  ${label})
    ${command}
    exit
    ;;
  '';

  print_script = ''#!/bin/sh
  case $ROFI_INFO in
    ${builtins.concatStringsSep "\n" (builtins.map print_action options)}
  *)
    ${builtins.concatStringsSep "\n" (builtins.map print_option options)}
    echo -en "\0prompt\x1f${prompt}\n"
    echo -en "\0use-info-message\x1ftrue\n"
    exit
    ;;
  esac
  '';

  layout = substituteAll ({
    src = ./menu.rasi;
    columns = (builtins.length options);
    width = (builtins.length options) * width;
    foreground = colors.foreground;
    background = colors.background;
    background_hl = colors.background-hl;
    emph = colors.secondary;
  });
	script = writeShellScriptBin "menu" (print_script);
  display = [
    "${rofi}/bin/rofi"
    "-theme ${layout}"
    "-show-icons"
    "-modi menu:${script}/bin/menu"
    "-show menu"
    "-kb-row-up Left"
    "-kb-row-down Right"
    "-kb-move-char-back ''"
    "-kb-move-char-forward ''"
  ];

in writeShellScriptBin "display" (builtins.concatStringsSep " " display)

