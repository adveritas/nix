{
  description = "wdreyer's Nix Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let
      systemSettings = {
        system = "x86_64-linux";
        profile = "nixos";
        hostname = "nixstation";
        timezone = "America/New_York";
        locale = "en_US.UTF-8";
      };

      userSettings = rec {
        name = "William Dreyer";
        username = "wdreyer";
      };

      pkgs = import nixpkgs { system = systemSettings.system; };

    in {
    nixosConfigurations = {
      ${systemSettings.profile} = nixpkgs.lib.nixosSystem {
        system = systemSettings.system;
        inherit pkgs;
        modules =
          [
            ./profiles/nixos/configuration.nix
            ./hardware-configuration.nix
          ];
        specialArgs = {
          inherit inputs;
          inherit systemSettings;
          inherit userSettings;
        };
      };
    };

    homeConfigurations = {
      ${userSettings.username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules =
          [
            ./profiles/nixos/home.nix
          ];
        extraSpecialArgs = {
          inherit inputs;
          inherit systemSettings;
          inherit userSettings;
        };
      };
    };
  };
}
