{ pkgs, modulesPath, lib, ... }:

{
  imports = [ "${modulesPath}/installer/cd-dvd/installation-cd-graphical-calamares-plasma5.nix" ];

  nixpkgs.hostPlatform = "x86_64-linux";
  # Enable the Plasma 5 Desktop Environment.

  environment.systemPackages = with pkgs; [
    firefox
    bcachefs-tools
    gparted
    parted
    git
    disko
   ];


  # Support choosing from any locale
  i18n.supportedLocales = [ "all" ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.displayManager = {
    # Automatically login as nixos.
      sddm.enable = true;
      autoLogin = {
        enable = true;
        user = "nixos";
      };
    };


  boot.kernelPackages = lib.mkOverride 0 pkgs.linuxPackages;
  services.xserver.videoDrivers = ["nvidia"];
  nixpkgs.config.allowUnfree = true;
  boot.supportedFilesystems.zfs = lib.mkForce false;
}

