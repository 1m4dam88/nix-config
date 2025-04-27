{ lib, pkgs, config, ... }:
{
  wayland.windowManager.river = {
    enable = true;
    xwayland.enable = true;
    settings = {
      set-repeat = "50 300";
      default-layout = "rivertile";
      border-width = 2;
      map = {
        normal = {
          "Super" = {
            Return = "spawn foot";
            Q = "close";
            W = "spawn zen";
            D = "spawn tofi-drun";
            F = "toggle-fullscreen";
            J = "focus next";
            K = "focus previous";
         };
          "Super+Shift" = {
            Q = "exit";
            Space = "toggle-float";
          };
        };
        # (lib.attrsets.mapAttrs
        #  (_mod: value: lib.attrsets.genAttrs (lib.lists.forEach (lib.lists.range 1 9) (num: toString num))
        #    (tag: value + builtins.replaceStrings [ "TAG" ] [ tag ] " $((1 << (TAG - 1)))"))
        #  {
        #    "Super" = "set-focused-tags";
        #    "Super+Shift" = "set-view-tags";
        #    "Super+Control" = "toggle-focused-tags";
        #    "Super+Shift+Control" = "toggle-view-tags";
        #  })
        # ];
        #map-pointer.normal."Super" = {
        #"BTN_LEFT" = "move-view";
        #"BTN_RIGHT" = "resize-view";
      };

    };
  };
}

