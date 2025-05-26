{ lib, pkgs, config, ... }:
{
  wayland.windowManager.river = {
    enable = true;
    xwayland.enable = true;
    settings = {
      set-repeat = "50 300";
      focus-follows-cursor = "always";
      default-layout = "rivertile";
      output-layout = "rivertile";
      attach-mode = "bottom";
      border-width = 2;
      spawn = [
        "rivertile"
      ];
      map.normal = lib.attrsets.zipAttrs [
        {
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
        }
        (lib.attrsets.mapAttrs
          (_mod: value: lib.attrsets.genAttrs (lib.lists.forEach (lib.lists.range 1 9) (num: toString num))
            (tag: value + builtins.replaceStrings [ "TAG" ] [ tag ] " $((1 << (TAG - 1)))"))
          {
            "Super" = "set-focused-tags";
            "Super+Shift" = "set-view-tags";
            "Super+Control" = "toggle-focused-tags";
            "Super+Shift+Control" = "toggle-view-tags";
          })
        ];
      };
    };
  }

