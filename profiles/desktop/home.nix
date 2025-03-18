{ config, pkgs, userSettings, ... }:

{
  home.username = userSettings.username;
  home.homeDirectory = "/home/"+userSettings.username;

  programs.home-manager.enable = true;

  imports =
    [
      ../../modules/user/git/git.nix
      ../../modules/user/browser/firefox.nix
    ];

  home.packages = with pkgs; [

  ];

  home.stateVersion = "24.11";
}
