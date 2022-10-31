{ ... }:

{

    xsession = {
        enable = true;
        initExtra = ''systemctl --user start barrierc.service'';
    };

    services.barrier.client = {
        enable = true;
        name = "nixos";
        enableCrypto = false;
        enableDragDrop = true;
        server = "192.168.1.50:24800";  
    };
}