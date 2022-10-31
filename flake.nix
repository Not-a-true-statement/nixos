{
  description = "Personal NixOS System Flake Configuration";

  inputs =
    {
      nixpkgs = {
        url = "github:nixos/nixpkgs/nixos-unstable";
      };
      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };

  outputs = inputs @ { self, nixpkgs, home-manager, ... }:   # Function that tells my flake which to use and what do what to do with the dependencies.
    let                                                                     # Variables that can be used in the config files.
      user = "tar";
      location = "$HOME/.setup";
    in                                                                      # Use above variables in ...
    {
      nixosConfigurations = (                                               # NixOS configurations
        import ./hosts {                                                    # Imports ./hosts/default.nix
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager user location;   # Also inherit home-manager so it does not need to be defined here.
        }
      );

      homeConfigurations = (                                                # Non-NixOS configurations
        import ./nix {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager user;
        }
      );
    };
}
