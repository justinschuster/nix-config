{ pkgs, ... }:
{
  nix = {
    # Determinate uses its own daemon to manage the Nix installation that
    # conflicts with nix-darwin's native Nix management.
    #
    # TODO: set this to false if you're using Determinate Nix.
    # NOTE: Turning off this option will invalidate all of the nix.settings in modules/common/nix.nix,
    # and you will need to manually modify /etc/nix/nix.custom.conf to add the corresponding parameters.
    enable = false;

    package = pkgs.nix;
  };
}
