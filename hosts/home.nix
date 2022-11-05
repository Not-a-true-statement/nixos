{ config, lib, pkgs, user, ... }:
{ 
  # Enable Home Manager
  # programs.home-manager.enable = false;
  
  # Home Manager Modules
  imports =
    (import ../modules/editors)   ++
    (import ../modules/programs)  ++
    (import ../modules/services)  ++
    (import ../modules/shell)     ++
    [(import ../modules/themes/default/homeconfig.nix)];

  # User
  home = {
    stateVersion = "22.05";
    username = "${user}";
    homeDirectory = "/home/${user}";
  };

  # Session terminal variables
  home.sessionVariables = {
  EDITOR = "nano";
  SUDO_EDITOR="code --wait";
  };    

  # Keybpard & switch layout
  home.keyboard = {
      layout = "us,se";
      options = [ "grp:alt_shift_toggle" ];
    };
  xsession = { initExtra = ''systemctl --user start setxkbmap.service xplugd.service''; enable = true; };

  # User packages
  home.packages = with pkgs; [
    # Terminal
    btop                      # Resource Manager
    pfetch                    # Minimal fetch
    ranger                    # File Manager
    
    # Video/Audio
    feh                       # Image Viewer
    mpv                       # Media Player
    pavucontrol               # Audio control
    plex-media-player         # Media Player
    vlc                       # Media Player
    stremio                   # Media Streamer

    # Apps
    appimage-run              # Runs AppImages on NixOS
    firefox-esr               # Browser (Long term support version) NOTE: This version work with Discord
    google-chrome             # Browser
    thunderbird               # Email client
    remmina                   # XRDP & VNC Client
    deluge                    # Torrent program
    libreoffice               # Office suite
    barrier                   # Over network keyboard and mouse share
    discord                   # Social media
    spotify                   # Music streaming client

    # File Management
    okular                    # PDF viewer
    pcmanfm                   # File Manager
    cinnamon.nemo             # File Manager
    gnome.file-roller         # Archive Manager
    gnome.gnome-disk-utility  # (Required for nemo disk view)
    rsync                     # Syncer $ rsync -r dir1/ dir2/
    unzip                     # Zip files
    unrar                     # Rar files


    # Creative
    kdenlive                  # Video editor
    mediainfo                 # Required by kdenlive
    audacity                  # Audio editor
    gimp                      # Image editor

    # Audio
    pavucontrol               # Audio control
    qjackctl                  # Audio router
    carla                     # Audio mixer/router
    x42-plugins               # Audio plugin collection
    lsp-plugins               # Audio plugin collection
    zam-plugins               # Audio plugin collection
    scream                    # Over network audio
    jacktrip                  # Jack audio over network

    # Development
    android-studio
    flutter
    nodejs

    # Fonts
    lmodern
  ];

  # Custom desktop entries
  xdg.desktopEntries = {
      firefox-incognito = {
          name = "Firefox Incognito";
          genericName = "Web Browser";
          icon = "firefox";
          exec = "firefox --private-window";
          terminal = false;
          categories = [ "Application" "Network" "WebBrowser" ];
          mimeType = [ "text/html" "text/xml" ];
      };
  };
}
