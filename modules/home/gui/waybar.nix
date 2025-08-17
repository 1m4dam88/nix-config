{ pkgs, ... }:
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
          format = "{:%d\n%m\n\n%H\n%M}";
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
          format = "{volume}%";
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
          font-family: "Caskaydia Cove Nerd Font";
          font-size: 10pt;
      
      }
      
      @define-color base00 #1d2021; @define-color base01 #3c3836;
      @define-color base02 #504945; @define-color base03 #665c54;
      @define-color base04 #bdae93; @define-color base05 #d5c4a1;
      @define-color base06 #ebdbb2; @define-color base07 #fbf1c7;
      
      @define-color base08 #fb4934; @define-color base09 #fe8019;
      @define-color base0A #fabd2f; @define-color base0B #b8bb26;
      @define-color base0C #8ec07c; @define-color base0D #83a598;
      @define-color base0E #d3869b; @define-color base0F #d65d0e;
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
        padding: 0 5px;
      }
      #upower.charging,
      #battery.Charging {
        padding: 0 5px;
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
        background-color: @base04;
        color: @base00;
      }
      #backlight {
        padding: 0 5px;
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
       #idle_inhibitor,
       #language,
       #network,
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
      #clock {
      	padding: 2px 0px 0px 0px;
      	font-size: 16px;
      }
      #pulseaudio {
        padding: 1px 0px;
      	margin: 1px 0px;
      }
    '';
  };

}
