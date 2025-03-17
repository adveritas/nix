{ config, pkgs, inputs, userSettings, systemSettings, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.${userSettings.username} = {
      extensions = [
        inputs.firefox-addons.packages.${systemSettings.system}.bitwarden
        inputs.firefox-addons.packages.${systemSettings.system}.ublock-origin
      ];
    };
  };
}

