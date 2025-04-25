{ config, pkgs, ... }:

{
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [ nvidia-vaapi-driver ];
  };
  
  services.jellyfin = {
    enable = true;
    hardwareAcceleration = true;
    httpsPort = null;
    environmentVariables = {
      # Enable NVENC/NVDEC
      LIBVA_DRIVER_NAME = "nvidia";
      NVIDIA_DRIVER_CAPABILITIES = "compute,video,utility";
      JELLYFIN_PublishedServerUrl = "https://jellyfin.your-domain.com";
    };
  };

  services.caddy = {
      enable = true;
      email = "${config.sops.secrets.email}";  # For Let's Encrypt notifications
  
      virtualHosts = {
        "jellyfin.tjd.lol" = {
          extraConfig = ''
            # Reverse proxy with WebSocket support
            reverse_proxy localhost:8096 {
              transport http {
                websocket
              }
            }
  
            # Security headers
            header {
              Strict-Transport-Security "max-age=31536000; includeSubDomains; preload"
              X-XSS-Protection "1; mode=block"
              X-Frame-Options "SAMEORIGIN"
              X-Content-Type-Options "nosniff"
              Referrer-Policy "strict-origin-when-cross-origin"
              Permissions-Policy "accelerometer=(), camera=(), geolocation=(), microphone=()"
            }
  
            # Allow large media uploads
            file_max_size 10GB
            request_body_max_size 10GB
          '';
        };
      };
  };
}
