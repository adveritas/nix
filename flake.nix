{
  description = "wdreyer's Nix Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs = inputs@{ self, nixpkgs, ... }:
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
        email = "w.h.dreyer@icloud.com";
        browser = "firefox";
        term = "kitty";
        editor = "neovim";
      };

    in {
    nixosConfigurations = {
      ${systemSettings.profile} = nixpkgs.lib.nixosSystem {
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
  };
}
