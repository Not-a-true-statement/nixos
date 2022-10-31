{ pkgs, config, callPackage, ... }:
let
obs-source-record = pkgs.callPackage ./obs-source-record.nix {};
in
{
  programs.obs-studio = {
    enable = true;

    plugins = [
      # pkgs.obs-studio-plugins.obs-ndi
      pkgs.obs-studio-plugins.obs-gstreamer
      pkgs.obs-studio-plugins.obs-multi-rtmp
      obs-source-record
    ];
  };    
}