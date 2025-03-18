{
  description = "wdreyer's Nix Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs = inputs@{ self, nixpkgs, ... }:
    let
      systemSettings = {
        system = "x86_64-linux";
        arch = "aarch64";
        hostname = "nixstation";
        timezone = "America/New_York";
        locale = "en_US.UTF-8";
      };

      userSettings = rec {
        name = "William Dreyer";
        username = "wdreyer";
        email = "w.h.dreyer@icloud.com";
        ssh-key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID5aEdUeGsejEWV1Gc5WddRDqQs9wE54Vk+Ju/Cubath";
      };
      
    in {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        system = (systemSettings.arch + "-linux");
        pkgs = import nixpkgs { system = (systemSettings.arch + "-linux"); };
        modules =
          [
            ./profiles/desktop/configuration.nix
            ./hardware-configuration.nix
          ];
        specialArgs = {
          inherit inputs;
          inherit systemSettings;
          inherit userSettings;
        };
      };
      server = nixpkgs.lib.nixosSystem {
	system = (systemSettings.arch + "-linux");
	pkgs = import nixpkgs { system = (systemSettings.arch + "-linux"); };
	modules = 
          [
	    ./profiles/server/configuration.nix
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
