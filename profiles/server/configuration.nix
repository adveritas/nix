{ modulesPath, lib, pkgs, systemSettings, userSettings, ... }:

{
  imports = 
    [
  
    ];

  boot.loader.grub = {
    efiSupport = true;  
    efiInstallAsRemovable = true;
    devices = [ "/dev/sda2" ];
  };

  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;


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


  services.openssh.enable = true;

  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
    pkgs.gitMinimal
  ];

  users.users.${userSettings.username} = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPpD8yghbIp8prILZOUi6WWswWkfQRW7zF5jALLFQW2s" ];   
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      neovim
      git
    ];
  };


  nix.settings.experimental-features = ["nix-command" "flakes"];  
  system.stateVersion = "24.11";
}
