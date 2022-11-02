{ nixpkgs, ... }:
{
    nixpkgs.overlays = [                          # This overlay will pull the latest version of Discord
    (self: super: {
      ndi = super.ndi.overrideAttrs (
        _: { src = builtins.fetchTarball {
          url = "https://downloads.ndi.tv/SDK/NDI_SDK_Linux/Install_NDI_SDK_v5_Linux.tar.gz"; 
          sha256 = "0j6a33dyi96gf3yzxgg08h10ki0xfpc9fcs7jmk77s5pckf0n671";
        };}
      );
    })

    (self: super: {
      discord = super.discord.overrideAttrs (
        _: { src = builtins.fetchTarball {
          url = "https://discord.com/api/download?platform=linux&format=tar.gz"; 
          sha256 = "1kwqn1xr96kvrlbjd14m304g2finc5f5ljvnklg6fs5k4avrvmn4";
        };}
      );
    })
  ];
}