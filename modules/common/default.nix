# Modules shared by every host, darwin or NixOS.
{
  imports = [
    ./nix.nix
    ./packages.nix
  ];
}
