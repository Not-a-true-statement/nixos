#
#  Services
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ home.nix
#   └─ ./modules
#       └─ ./services
#           └─ default.nix *
#               └─ ...
#

[
  ./awesomewm
  # ./dunst.nix
  # ./flameshot.nix
  ./picom.nix
  ./pipewire.nix
  ./barrier.nix
  #./polybar.nix
  #./sxhkd.nix
  # ./udiskie.nix
  #./redshift.nix
]

# picom, polybar and sxhkd are pulled from desktop module
# redshift temporarely disables
