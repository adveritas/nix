

{ config, lib, pkgs, userSettings, systemSettings, ... }:

{
  imports =
    [

    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = systemSettings.hostname;


  time.timeZone = systemSettings.timezone; # time zone
  i18n.defaultLocale = systemSettings.locale;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = systemSettings.locale;
    LC_IDENTIFICATION = systemSettings.locale;
    LC_MEASUREMENT = systemSettings.locale;
    LC_MONETARY = systemSettings.locale;
    LC_NAME = systemSettings.locale;
    LC_NUMERIC = systemSettings.locale;
    LC_PAPER = systemSettings.locale;
    LC_TELEPHONE = systemSettings.locale;
    LC_TIME = systemSettings.locale;
  };


  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true; 


  users.users.${userSettings.username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      neovim
    ];
  };


  environment.systemPackages = with pkgs; [

  ];


  nix.settings.experimental-features = ["nix-command" "flakes"];
  system.stateVersion = "24.11";
}

