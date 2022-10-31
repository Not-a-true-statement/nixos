{ pkgs, ... }:

{
    xsession = {
        enable = true;

        windowManager.awesome = {
            enable = true;
            
            luaModules = with pkgs.luaPackages; [
                luarocks # is the package manager for Lua modules
                luadbi-mysql # Database abstraction layer
            ];
        };

        initExtra =
            ''
            # TRAY
            ${pkgs.pasystray}/bin/pasystray &
            ${pkgs.blueman}/bin/blueman-applet &
            ${pkgs.networkmanagerapplet}/bin/nm-applet --sm-disable --indicator &
            ${pkgs.deluge}/bin/deluge &
            ${pkgs.qjackctl}/bin/qjackctl --preset=Default &
            
            # Background
            # TODO Carla setup
            ${pkgs.autorandr}/bin/autorandr --change
            ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &
            '';
    };

    # home.file."awesome" = {
    #     source = ./config;
    #     target = "./.config/awesome";
    # };

    # xdg.portal = {                                  # Required for flatpak with windowmanagers
    #     enable = true;
    #     extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    # };
}