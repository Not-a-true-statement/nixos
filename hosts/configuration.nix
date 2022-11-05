{ config, lib, pkgs, inputs, user, location, ... }:
{
  # System User
  users.users.${user} = {
    password = "test";
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "audio"
      "realtime"
      "camera"
      "networkmanager"
      "lp"
      "scanner"
      "kvm"
      "libvirtd"
      "plex"
      "adbusers"
      "i2c"
    ];
    
    # Default shell
    shell = pkgs.zsh;
    # shell = pkgs.bash;
  };
  security.sudo.wheelNeedsPassword = false; # User does not need to give password when using sudo.

  time.timeZone = "Europe/Stockholm";        # Time zone and internationalisation
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {                 # Extra locale settings that need to be overwritten
      LC_TIME = "sv_SE.UTF-8";
      LC_MONETARY = "sv_SE.UTF-8";
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";	                    # or us/azerty/etc
  };

  fonts.fonts = with pkgs; [                # Fonts
    carlito                                 # NixOS
    vegur                                   # NixOS
    source-code-pro
    jetbrains-mono
    font-awesome                            # Icons
    corefonts                               # MS
    (nerdfonts.override {                   # Nerdfont Icons override
      fonts = [
        "FiraCode"
      ];
    })
  ];

  nixpkgs.overlays = [

    (self: super: {
      discord = super.discord.overrideAttrs (
        _: { src = builtins.fetchTarball {
          url = "https://discord.com/api/download?platform=linux&format=tar.gz"; 
          sha256 = "1pw9q4290yn62xisbkc7a7ckb1sa5acp91plp2mfpg7gp7v60zvz";
        };}
      );
    })
  ];

  environment = {
    variables = {
      TERMINAL = "alacritty";
      EDITOR = "nano";
      VISUAL = "nano";
    };
    systemPackages = with pkgs; [           # Default packages install system-wide
      # System Utilities
      killall           # Killall programs with name
      nano              # Text editor
      vim               # Text editor
      git               # Source control
      pciutils          # Pcie Utilities
      usbutils          # USB Utilities
      wget              # Retrive from web server
      libnotify         # Norification Utilities
      dmidecode
      neofetch

      # Filesystem Support
      ntfs3g            # NTFS
      exfat             # exFat
    ];
  };

  # Sound
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

  # Network
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.firewall.enable = false;

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # SSH
  services = {
    openssh = {                            
      enable = true;                        
      # SSH: secure shell (remote connection to shell of server)
      # local: $ ssh <user>@<ip>
      # public:
      #   - port forward 22 TCP to server
      #   - in case you want to use the domain name insted of the ip:
      #       - for me, via cloudflare, create an A record with name "ssh" to the correct ip without proxy
      #   - connect via ssh <user>@<ip or ssh.domain>
      # generating a key:
      #   - $ ssh-keygen   |  ssh-copy-id <ip/domain>  |  ssh-add
      #   - if ssh-add does not work: $ eval `ssh-agent -s`
      allowSFTP = true;                     
      # SFTP: secure file transfer protocol (send file to server)
      # connect: $ sftp <user>@<ip/domain>
      #   or with file browser: sftp://<ip address>
      # commands:
      #   - lpwd & pwd = print (local) parent working directory
      #   - put/get <filename> = send or receive file
      extraConfig = ''
        HostKeyAlgorithms +ssh-rsa
      '';                                   
      # Temporary extra config so ssh will work in guacamole
    };
    flatpak.enable = true;
    # download flatpak file from website - sudo flatpak install <path> - reboot if not showing up
    # sudo flatpak uninstall --delete-data <app-id> (> flatpak list --app) - flatpak uninstall --unused
    # List:
    # com.obsproject.Studio
    # com.parsecgaming.parsec
    # com.usebottles.bottles
  };

  xdg.portal = {                                  # Required for flatpak with windowmanagers
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  nix = {                                   # Nix Package Manager settings
    settings ={
      auto-optimise-store = true;           # Optimise syslinks
    };
    gc = {                                  # Automatic garbage collection
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
    package = pkgs.nixVersions.unstable;    # Enable nixFlakes on system
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };
  nixpkgs.config.allowUnfree = true;        # Allow proprietary software.

  system = {                                # NixOS settings
    autoUpgrade = {                         # Allow auto update (not useful in flakes)
      enable = true;
      channel = "https://nixos.org/channels/nixos-unstable";
    };
    stateVersion = "22.05";
  };

  programs.dconf.enable = true;

  services.xserver = {
    enable = true;

    desktopManager.plasma5.enable = true;

    displayManager = {
      sddm.enable = true;
      sddm.theme = "${(pkgs.fetchFromGitHub {
        owner = "MarianArlt";
        repo = "kde-plasma-chili";
        rev = "a371123959676f608f01421398f7400a2f01ae06";
        sha256 = "17pkxpk4lfgm14yfwg6rw6zrkdpxilzv90s48s2hsicgl3vmyr3x";
      })}";

      defaultSession = "none+awesome";
    };
    windowManager.awesome.enable = true;
  };
}

