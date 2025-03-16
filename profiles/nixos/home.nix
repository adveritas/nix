{ config, pkgs, userSettings, ... }:

{
  home.username = userSettings.username;
  home.homeDirectory = "/home/"+userSettings.username;

  programs.home-manager.enable = true;

  imports =
    [

    ];

  home.packages = with pkgs; [
    zsh
    alacritty
    brave
  ];

  home.stateVersion = "24.11";
}
