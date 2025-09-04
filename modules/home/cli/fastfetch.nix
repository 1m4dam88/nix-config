{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "small";
        padding = {
            top = 1;
        };
    };
    display = {
        separator = "  ";
    };
    modules = [
        {
            type = "os";
            key = "os    ";
            keyColor = "red";
        }
        {   
            type = "hostname";
            key = "hname ";
            keyColor = "green";
        }
        {
            type = "kernel";
            key = "kernel";
            keyColor = "yellow";
        }
        {
            type = "host";
            format = "{vendor} {family}";
            key = "host  ";
            keyColor = "blue";
        }
        {
            type = "packages";
            key = "pkgs  ";
            keyColor = "magenta";
        }
        {
            type = "uptime";
            format = "{?days}{days}d {?}{hours}h {minutes}m";
            key = "uptime";
            keyColor = "red";
        }
        {   type = "localip";
            key = "ip    ";
            format = "{ipv4} ";
            keyColor = "green";
        }
        {
            type = "memory";
            key = "memory";
            keyColor = "yellow";
        }
      ];
    };
  };
}
