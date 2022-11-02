{ pkgs, lib, user, config, ... }:

{
  imports =                                               # For now, if applying to other system, swap files
    [(import ./hardware-configuration.nix)] ++            # Current system hardware config @ /etc/nixos/hardware-configuration.nix
    # [(import ../../modules/programs/games.nix)] ++        # Gaming
    # [(import ../../modules/desktop/bspwm/default.nix)] ++   # Window Manager
    #[(import ../../modules/desktop/hyprland/default.nix)] ++ # Window Manager
    #[(import ../../modules/desktop/gnome/default.nix)] ++ # Desktop Environment
    # [(import ../../modules/editors/emacs/native.nix)] ++  # Native doom emacs instead of nix-community flake
    # (import ../../modules/desktop/virtualisation) ++      # Virtual Machines
    (import ../../modules/hardware);                      # Hardware devices

  boot = {                                      # Boot options
    kernelPackages = pkgs.linuxPackages_latest;
    #initrd.kernelModules = [ "amdgpu" ];       # Video drivers

    loader = {                                  # For legacy boot:
      systemd-boot = {
        enable = true;
        configurationLimit = 5;                 # Limit the amount of configurations
      };
      efi.canTouchEfiVariables = true;
      timeout = 1;                              # Grub auto select time
    };
  };

  # GPU drivers
  services.xserver.videoDrivers = [ "nvidia" ];

  # For virtual camera in obs
  boot = {
    extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback.out
    ];
    kernelModules = [
      "i2c-dev" 
      "v4l2loopback"
    ];
    extraModprobeConfig =
      ''
      options v4l2loopback nr_devices=2 exclusive_caps=1,1,1,1,1,1,1,1 video_nr=0,1 card_label=Virtual-0,Virtual-1
      '';
  };
  services.udev.extraRules =
    ''
    # allow admin use of i2c devices
    ACTION=="add", KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="666"
    '';


  hardware = {
    sane = {                                    # Used for scanning with Xsane
      enable = true;
      extraBackends = [ pkgs.sane-airscan ];
    };
  };

  environment = {                               # Packages installed system wide
    systemPackages = with pkgs; [               # This is because some options need to be configured.
      
      # Itilities
      ddcutil                 # Montior control program
      ddcui                   # ddcutil graphicical UI 
    ];
  };


  services = {
    printing = {                                # Printing and drivers for TS5300
      enable = true;
      # drivers = [ pkgs.cnijfilter2 ];           # There is the possibility cups will complain about missing cmdtocanonij3. I guess this is just an error that can be ignored for now.
    };
    avahi = {                                   # Needed to find wireless printer
      enable = true;
      nssmdns = true;
      publish = {                               # Needed for detecting the scanner
        enable = true;
        addresses = true;
        userServices = true;
      };
    };
    # samba = {                                   # File Sharing over local network
    #   enable = true;                            # Don't forget to set a password:  $ smbpasswd -a <user>
    #   shares = {
    #     share = {
    #       "path" = "/home/${user}";
    #       "guest ok" = "yes";
    #       "read only" = "no";
    #     };
    #   };
    #   openFirewall = true;
    # };
  };
}
