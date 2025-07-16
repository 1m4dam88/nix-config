{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        height = 26;

        modules-left = [
          "hyprland/workspaces"
          "mpris"
        ];
        modules-center = [
          "hyprland/window"
        ];
        modules-right = [
          "network"
          "hyprland/language"
          "backlight"
          "pulseaudio"
          "power-profiles-daemon"
          "idle_inhibitor"
          "battery"
          "clock"
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

        clock = {
          format = "{:%d/%m %H:%M}";
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
          format = "BAT:{capacity}%";
          states = {
            warning = 30;
            critical = 10;
          };
          "format-full" = "BAT:FULL";
          "format-charging" = "CHARGE:{capacity}%";
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
          format = "DIS:{percent}%";
          "format-icons" = [
            ""
            ""
          ];
          tooltip = false;
          interval = 60;
        };

        pulseaudio = {
          format = "SND:{volume}%";
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

       * {
       	font-family: "Caskaydia Cove Nerd Font";
       	font-size: 12pt;
       }

       .modules-left {
       /*	background-color: #1d2021;*/
       }


       .modules-right {
       /*	background-color: #1d2021;*/
       }

       #workspaces {
       }

       #workspaces button {
       	padding: 0px 6px 0px 6px;
       	color: #f5f5f5;
       	background-color: #1d2021;
       	border-radius: 0;
       }


       #workspaces button.active {
       	border-top: 0px ;
       	border-right: 0px ;
       	border-left: 0px ;
       	border-bottom: 0px ;
       	color: #FFFFFF;
        background-color: #1d2021;
       	border-radius: 0;
       }

       #workspaces button:hover {
       	border-top: 0px;
       	border-right: 0px;
       	border-left: 0px;
       	border-bottom: 0px;
        color: #1d2021;
        background-color: #ffffff;
       	border-radius: 0;
       }

       #window {
       	color: #ffffff;
       	background-color: inherit;
       	padding: 0px 0px 0px 6px;
       }

       window#waybar {
       	background-color: #1d2021;
       }

       #mpris {
       	color: #ffffff;
       	background-color: #1d2021;
       	padding: 0px 0px 0px 6px;
       }

       window#waybar.empty {
       	background-color: #1d2021;
       }

       /* weird padding rules */
       #backlight,
       #battery,
       #pulseaudio,
       #idle_inhibitor,
       #language,
       #network,
       #clock,
       #power-profiles-daemon{
       	padding: 0px 6px 0px 6px;
       	color: #f5f5f5;
       	background-color: #1d2021
       }
       #tray {
       	padding: 0px 0px 0px 6px;
       	background-color: #1d2021
       }

       #pulseaudio.bluetooth {
       	color: #73d836;
       }

       #battery.full{
       	color: #73d836;
       }

       #battery.warning {
       	color: #ffdd33;
       }

       #battery.critical {
       	color: #f43841;
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
    '';
  };

}
