# nix-darwin modules shared by every macOS host.
{
  imports = [
    ../common
    ./nix.nix
    ./users.nix
    ./homebrew.nix
    ./system.nix
  ];
}
