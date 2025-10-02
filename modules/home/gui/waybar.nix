{ config, libs, pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "right";
        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [
        ];
        modules-right = [
          "backlight"
          "pulseaudio"
          "battery"
          "clock#date"
          "tray"
        ];

        "hyprland/workspaces" = {
          format = "{id}";
        };

        "mpris" = {
          format = "{artist} - {title}";
        };

        "hyprland/window" = {
          format = "{}";
          "max-length" = 150;
        };

        tray = {
          "icon-size" = 16;
          spacing = 8;
        };

        "clock#time" = {
          format = "󰥔 {:%H%M}";
          "tooltip-format" = "<tt><small>{calendar}</small></tt>";
        };

        clock = {
          format = " {:%d/%m}";
          interval = 30;
          "tooltip-format" = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            "mode-mon-col" = 3;
            "weeks-pos" = "right";
            "on-scroll" = 1;
            "on-click-right" = "mode";
            format = {
              months = "<span>{}</span>";
              days = "<span>{}</span>";
              weeks = "<span>W{}</span>";
              weekdays = "<span>{}</span>";
              today = "<span color='#f43841'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            "on-click-right" = "mode";
            "on-click-forward" = "tz_up";
            "on-click-backward" = "tz_down";
            "on-scroll-up" = "shift_up";
            "on-scroll-down" = "shift_down";
          };
        };

        "power-profiles-daemon" = {
          format = "{icon}";
          "format-icons" = {
            default = "DEF";
            performance = "PWR";
            balanced = "BAL";
            "power-saver" = "SAV";
          };
        };

        "idle_inhibitor" = {
          format = "IDLE:{icon}";
          "format-icons" = {
            activated = "OFF";
            deactivated = "ON";
          };
          tooltip = true;
          "tooltip-format-activated" = "Idle block Activated ";
          "tooltip-format-deactivated" = "Idle block Deactivated ";
        };

        battery = {
          format = "󰁹 {capacity}%";
          states = {
            warning = 30;
            critical = 10;
          };
          "format-full" = "󰁹 100%";
          "format-charging" = "󰂄 {capacity}%";
          "format-icons" = [
            ""
            ""
            ""
            ""
            ""
          ];
          tooltip = true;
          "tooltip-format" = "Power draw: {power}W, Time: {time}, Health: {health}%";
          "tooltip-format-full" = "Fully charged ";
          interval = 30;
        };

        network = {
          "format-ethernet" = "ETH";
          "format-wifi" = "WIFI:{signalStrength}%";
          "format-disconnected" = "NO NET";
          "on-click" = "$CUR_TERMINAL -e ${pkgs.networkmanager}/bin/nmtui";
          "tooltip-format" = "{ifname} via {gwaddr}";
          "tooltip-format-wifi" = "{essid} ({signalStrength}%) ";
          "tooltip-format-ethernet" = "{ifname} ";
          "tooltip-format-disconnected" = "Disconnected ";
        };

        backlight = {
          format = "󰞏 {percent}%";
          "format-icons" = [
            ""
            ""
          ];
          tooltip = false;
          interval = 60;
        };

        pulseaudio = {
          format = " {volume}%";
          "format-bluetooth" = "SND:{volume}%";
          "format-muted" = "NO SND";
          "format-icons" = {
            default = [
              ""
              ""
            ];
          };
          "on-click" = "${pkgs.lxqt.pavucontrol-qt}/bin/pavucontrol-qt";
          "on-click-middle" = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        };

        "hyprland/language" = {
          format = "KEY:{}";
          "format-en" = "EN";
          "format-gr" = "GR";
          tooltip = false;
        };
      };
    };
    style = ''
      window#waybar, tooltip {
          background: alpha(@base00, 1.000000);
      }
      
      * {
          font-family: "Cozette";
          font-size: 10pt;
      
      }
      
      @define-color base00 #${config.lib.stylix.colors.base00};
      @define-color base01 #${config.lib.stylix.colors.base01};
      @define-color base02 #${config.lib.stylix.colors.base02};
      @define-color base03 #${config.lib.stylix.colors.base03};
      @define-color base04 #${config.lib.stylix.colors.base04};
      @define-color base05 #${config.lib.stylix.colors.base05};
      @define-color base06 #${config.lib.stylix.colors.base06};
      @define-color base07 #${config.lib.stylix.colors.base07};
      @define-color base08 #${config.lib.stylix.colors.base08};
      @define-color base09 #${config.lib.stylix.colors.base09};
      @define-color base0A #${config.lib.stylix.colors.base0A};
      @define-color base0B #${config.lib.stylix.colors.base0B};
      @define-color base0C #${config.lib.stylix.colors.base0C};
      @define-color base0D #${config.lib.stylix.colors.base0D};
      @define-color base0E #${config.lib.stylix.colors.base0E};
      @define-color base0F #${config.lib.stylix.colors.base0F};
      window#waybar, tooltip {
          color: @base05;
      }
      
      tooltip {
          border-color: @base0D;
      }
      #wireplumber,
      #pulseaudio {
        padding: 1px 0px;
      	margin: 1px 0px;
        color: @base0A;
      }
      #sndio {
        padding: 0 5px;
      }
      #wireplumber.muted,
      #pulseaudio.muted,
      #sndio.muted {
        padding: 0 5px;
      }
      #upower,
      #battery {
        color: @base0B;
      }
      #upower.charging,
      #battery.Charging {
        color: @base0B;
      }
      #network {
        padding: 0 5px;
      }
      #network.disconnected {
        padding: 0 5px;
      }
      #user {
        padding: 0 5px;
      }
      #clock {
      	padding: 2px 0px 0px 0px;
      	font-size: 16px;
        color: @base0E;
      }
      #backlight {
        color: @base08;
      }
      #cpu {
        padding: 0 5px;
      }
      #disk {
        padding: 0 5px;
      }
      #idle_inhibitor {
        padding: 0 5px;
      }
      #temperature {
        padding: 0 5px;
      }
      #mpd {
        padding: 0 5px;
      }
      #language {
        padding: 0 5px;
      }
      #keyboard-state {
        padding: 0 5px;
      }
      #memory {
        padding: 0 5px;
      }
      #window {
        padding: 0 5px;
      }
      #bluetooth {
        padding: 0 5px;
      }
      #bluetooth.disabled {
        padding: 0 5px;
      }
      .modules-left #workspaces button {
          border-bottom: 3px solid transparent;
      }
      .modules-left #workspaces button.focused,
      .modules-left #workspaces button.active {
          border-bottom: 3px solid @base05;
      }
      .modules-center #workspaces button {
          border-bottom: 3px solid transparent;
      }
      .modules-center #workspaces button.focused,
      .modules-center #workspaces button.active {
          border-bottom: 3px solid @base05;
      }
      .modules-right #workspaces button {
          border-bottom: 3px solid transparent;
      }
      .modules-right #workspaces button.focused,
      .modules-right #workspaces button.active {
          border-bottom: 3px solid @base05;
      }
      
      
       * {
       	font-family: "DepartureMono Nerd Font Mono";
       	font-size: 12pt;
       }
      
       .modules-left {
       /*	background-color: @base00;*/
       }
      
      
       .modules-right {
       /*	background-color: @base00;*/
       }
      
       #workspaces {
       }
      
       #workspaces button {
       	padding: 0px 6px 0px 6px;
       	color: #f5f5f5;
       	background-color: @base00;
       	border-radius: 0;
       }
      
      
       #workspaces button.active {
       	border-top: 0px ;
       	border-right: 0px ;
       	border-left: 0px ;
       	border-bottom: 0px ;
       	color: #FFFFFF;
        background-color: @base00;
       	border-radius: 0;
       }
      
       #workspaces button:hover {
       	border-top: 0px;
       	border-right: 0px;
       	border-left: 0px;
       	border-bottom: 0px;
        color: @base00;
        background-color: #ffffff;
       	border-radius: 0;
       }
      
       #window {
       	color: #ffffff;
       	background-color: inherit;
       	padding: 0px 0px 0px 6px;
       }
      
       window#waybar {
       	background-color: @base00;
       }
      
       #mpris {
       	color: #ffffff;
       	background-color: @base00;
       	padding: 0px 0px 0px 6px;
       }
      
       window#waybar.empty {
       	background-color: @base00;
       }
      
       /* weird padding rules */
       #backlight {
         color: @base08;
       }
       #battery {
         color: @base0B;
       }
       #idle_inhibitor,
       #language,
       #network,
       #power-profiles-daemon{
       	padding: 0px 6px 0px 6px;
       	color: #f5f5f5;
       	background-color: @base00
       }
       #tray {
       	padding: 0px 0px 0px 6px;
       	background-color: @base00
       }
      
       #pulseaudio.bluetooth {
       	color: #73d836;
       }
      
       #battery.full{
         color: @base0B;
       }
      
       #battery.warning {
         color: @base0B;
       }
      
       #battery.critical {
         color: @base0B;
       }
      
       #network.disconnected {
       	color: #f43841;
      }
      
      #idle_inhibitor.activated {
      	color: #f43841;
      }
      
      #power-profiles-daemon.performance {
      	color: #ffdd33;
      }
      
      #power-profiles-daemon.power-saver {
      	color: #73d936;
      }
      
      #pulseaudio.muted {
      	color: #f43841;
      }
      #clock {
      	padding: 2px 0px 0px 0px;
      	font-size: 16px;
      }
      #pulseaudio {
        padding: 1px 0px;
      	margin: 1px 0px;
        color: @base0A;
      }
    '';
  };

}
