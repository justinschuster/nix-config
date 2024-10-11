{ config, pkgs, username, ... }: { 
  imports =
    [
      ../../services/i3.nix
      ../../services/system.nix

      ./hardware-configuration.nix
    ];

  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = ["networkmanager" "wheel"];
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "dell-laptop";
  networking.networkmanager.enable = true;

  programs.firefox.enable = true;

  system.stateVersion = "24.05";
}
