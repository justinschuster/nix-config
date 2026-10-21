{ pkgs, ... }:
{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Packages available to all users on every host.
  environment.systemPackages = with pkgs; [
    git
  ];
  environment.variables.EDITOR = "nvim";
}
