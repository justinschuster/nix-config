{ config, pkgs, ... }: {
  imports =
    [
      ../../services/i3.nix
      ../../services/system.nix

      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "dell-laptop";
  networking.networkmanager.enable = true;

  programs.firefox.enable;

  system.stateVersion = "24.05";
}
