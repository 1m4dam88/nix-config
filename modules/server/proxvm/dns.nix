{ config, pkgs, ... }:

{
  # Enable Unbound DNS resolver
  services.unbound = {
    enable = true;

    # Define Unbound settings
    settings = {
      server = {
        # Bind to a non-default port (default is 53)
        port = 5335;

        # Enable caching
        cache-max-ttl = 86400;  # Maximum TTL for cache (1 day)
        cache-min-ttl = 3600;   # Minimum TTL for cache (1 hour)
        harden-dnssec-stripped = "yes";  # Enforce DNSSEC validation
        do-ip4 = "yes";         # Enable IPv4
        do-ip6 = "no";         # Enable IPv6 (disable if not needed)
        do-udp = "yes";         # Enable UDP
        do-tcp = "yes";         # Enable TCP
        harden-referral-path = "yes";  # Additional security for referrals
        prefetch = "yes";       # Prefetch DNS records before they expire
        prefetch-key = "yes";   # Prefetch DNSKEYs for faster validation
        num-threads = 2;
        rrset-cache-size = "256m";
        msg-cache-size = "128m";
        so-rcvbuf = "1m";

        # Interface to listen on (0.0.0.0 for all interfaces)
        interface = [ "0.0.0.0" "::0" ];

        # Access control (adjust based on your network)
        access-control = [
          "0.0.0.0/0 allow"    # Allow all IPv4 clients
          "::0/0 allow"        # Allow all IPv6 clients
        ];

        # Define private domain for tjd.lol
        private-domain = [ "tjd.lol" ];
      };

      # Forward upstream DNS servers for non-local queries
      forward-zone = [
        {
          name = ".";
          forward-addr = [
            "8.8.8.8"        # Google DNS
            "8.8.4.4"        # Google DNS
            "1.1.1.1"        # Cloudflare DNS
            "1.0.0.1"        # Cloudflare DNS
          ];
          forward-first = "no";  # Use stub resolver (faster)
        }
      ];
    };
  };
  services.adguardhome = {
    enable = true;
    openFirewall = true;  # Automatically open firewall ports
    port = 3000;  # Use default DNS port (53) for AdGuard Home
    host = "0.0.0.0";  # Listen on all interfaces
    settings = {
      # General settings
      http = {
        address = "0.0.0.0:3000";  # Web interface accessible on all interfaces
      };

      # DNS settings
      dns = {
        bind_hosts = [ "0.0.0.0" "::0" ];  # Listen on all IPv4 and IPv6 interfaces
        port = 53;  # DNS port
        upstream_dns = [
          "[/tjd.lol/]127.0.0.1:5335"  # Forward DNS queries to Unbound on port 5353
        ];
        # Bootstrap DNS for resolving upstream servers (if needed)
        bootstrap_dns = [
          "8.8.8.8"
          "8.8.4.4"
          "1.1.1.1"
          "1.0.0.1"
        ];
        # Allow local domain resolution for tjd.lol
        local_domain_name = "tjd.lol";
        use_private_ptr_resolvers = true;  # Resolve private domains locally
        local_ptr_upstreams = [
          "127.0.0.1:5353"  # Use Unbound for reverse DNS (PTR) lookups
        ];
        # Enable DNS caching in AdGuard Home
        cache_enabled = true;
        cache_ttl_min = 3600;  # Minimum TTL (1 hour)
        cache_ttl_max = 86400; # Maximum TTL (1 day)
        # DNS security settings
        enable_dnssec = true;  # Enable DNSSEC (Unbound handles validation)
        ratelimit = 20;  # Queries per second per client
      };

      # Filtering settings (example)
      filters = [
        {
          enabled = true;
          url = "https://adguardteam.github.io/AdGuardSDNSFilter/Filters/filter.txt";
          name = "AdGuard DNS filter";
          id = 1;
        }
      ];
      filtering_enabled = true;
      safebrowsing_enabled = true;
      parental_enabled = false;  # Enable if you want parental controls
    };
  };

  # Open firewall for the custom port
  networking.firewall = {
    allowedUDPPorts = [ 5353 ];
    allowedTCPPorts = [ 5353 ];
  };
}
