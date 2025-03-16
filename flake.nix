{
  description = "wdreyer's Nix Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let
      systemSettings = {
        system = "x86_64-linux";
        hostname = "nixos";
        timezone = "America/New_York";
        locale = "en_US.UTF-8";
      };

      userSettings = rec {
        name = "William Dreyer";
        username = "wdreyer";
        email = "w.h.dreyer@icloud.com";
        browser = "firefox";
        term = "kitty";
        editor = "neovim";
      };

    in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = systemSettings.system;
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
      user = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = systemSettings.system; };
        modules = [ ./profiles/nixos/home.nix ];
        extraSpecialArgs = {
            inherit inputs;
            inherit systemSettings;
            inherit userSettings;
        };
      };
    };
  };
}
