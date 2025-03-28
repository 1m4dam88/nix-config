{
 programs.fish = {
    enable = true;

    shellInit = ''
      if uwsm check may-start
      exec uwsm start hyprland
    end
    '';

    interactiveShellInit = ''
      set fish_greeting
      function fish_user_key_bindings
        fish_vi_key_bindings
      end
    '';

    shellAliases = {
      "cp" = "cp -iv";
      "mv" = "mv -iv";
      "rm" = "rm -vI";
      "rsync" = "rsync -vrPlu";
      "md" = "mkdir -pv";
      
      "g" = "git";
      "gca" = "git clone";
      "ga" = "git add";
      "gaa" = "git add -A";
      "gc" = "git commit";
      "gcm" = "git commit -m";
      "gp" = "git push";
      
      "yt" = "yt-dlp --embed-metadata -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4'";
      "yta" = "yt -x -f bestaudio/best";
      "ffmpeg" = "ffmpeg -hide_banner";
      
      "ls" = "eza --group-directories-first";
      "ll" = "eza -l";
      "grep" = "rg";
      "cat" = "bat";
      "cd" = "z";
      
      "ka" = "killall";
      "nr" = "nixos-rebuild";
    };
 };
}

