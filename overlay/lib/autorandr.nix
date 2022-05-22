let
  # Parse window resolutions and positions to and from strings
  dump = display: display.display // {
    position = "${builtins.toString display.x}x${builtins.toString display.y}";
  };

  parse = display: let
    split = builtins.elemAt (builtins.split "([0-9]+)x([0-9]+)" display.mode) 1;
    size = builtins.map builtins.fromJSON split;
  in {
    display = display;
    x = 0;
    y = 0;
    w = builtins.elemAt size 0;
    h = builtins.elemAt size 1;
  };

  stack = stack_fx: monitors: (builtins.foldl' (virtual: raw: let
      next = if (raw ? x) then (raw) else (parse raw);
      s = stack_fx virtual next;
    in virtual // {
      displays = virtual.displays ++ [(next // s.display)];
    } // s.root)
    {
      x = 0;
      y = 0;
      w = 0;
      h = 0;
      displays = [];
    }
    monitors
  );
in {
  hstack = stack (virtual: next: {
    display = {
      x = virtual.w;
      y = virtual.y;
    };
    root = {
      w = virtual.w + next.w;
      h = if virtual.h > next.h then virtual.h else next.h;
    };
  });

  vstack = stack (virtual: next: {
    display = {
      x = virtual.x;
      y = virtual.h;
    };
    root = {
      w = if virtual.w > next.w then virtual.w else next.w;
      h = virtual.h + next.h;
    };
  });

  primary = monitor: monitor // { primary = true; };

  config = virtual: let
    dump_displays = display:
      if display ? displays then
        builtins.foldl' (l: next: (l ++ (dump_displays next))) [] display.displays
      else
        [(dump display)];

    config_list = builtins.foldl' (acc: next: {
      index = acc.index + 1;
      displays = acc.displays ++ [{
        name = "display-${builtins.toString acc.index}";
        value = next;
      }];
    }) {
      displays = [];
      index = 0;
    } (dump_displays virtual);

    config = builtins.listToAttrs config_list.displays;

  in {
    config = builtins.mapAttrs (key: value: (builtins.removeAttrs value ["fingerprint"])) config;
    fingerprint = builtins.mapAttrs (key: value: value.fingerprint) config;
  };
}
