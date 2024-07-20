{ pkgs, modulesPath, lib, ... }:
let
  calamares-nixos-autostart = pkgs.makeAutostartItem { name = "io.calamares.calamares"; package = pkgs.calamares-nixos; };
in
{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-base.nix"
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
  # Enable the Plasma 5 Desktop Environment.

  services = {
  xserver.enable = true;
  desktopManager.plasma5.enable = true;
    displayManager.sddm = {
     enable = true;
     #wayland.enable = true;
    };
    displayManager.sddm.settings = {        # Set sddm settings
      Theme = {
        CursorTheme = "breeze_cursors";
      };
    };
  };
  environment.systemPackages = with pkgs; [
    firefox
    bcachefs-tools
    gparted
    parted
    git
    disko
    wezterm
    # Calamares for graphical installation
    #libsForQt5.kpmcore
    #calamares-nixos
    #calamares-nixos-autostart
    #calamares-nixos-extensions
    # Get list of locales
    #glibcLocales
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
  boot.supportedFilesystems.zfs = lib.mkForce false;
}

