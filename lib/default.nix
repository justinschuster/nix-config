# Helpers that turn a host description into a full system configuration.
# Every module (and Home Manager module) receives `inputs`, `username` and
# `hostname` through specialArgs.
inputs:
let
  inherit (inputs) nixpkgs darwin home-manager;

  mkSpecialArgs = { username, hostname }: inputs // { inherit username hostname; };

  homeManagerConfig =
    {
      specialArgs,
      username,
      platform,
    }:
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = specialArgs;
      home-manager.users.${username}.imports = [
        ../home/common
        ../home/${platform}
      ];
    };
in
{
  mkDarwinSystem =
    {
      hostname,
      system,
      username ? "justin",
      modules ? [ ],
    }:
    let
      specialArgs = mkSpecialArgs { inherit username hostname; };
    in
    darwin.lib.darwinSystem {
      inherit system specialArgs;
      modules = [
        ../modules/darwin
        inputs.nix-homebrew.darwinModules.nix-homebrew
        home-manager.darwinModules.home-manager
        (homeManagerConfig {
          inherit specialArgs username;
          platform = "darwin";
        })
      ]
      ++ modules;
    };

  mkNixosSystem =
    {
      hostname,
      system,
      username ? "justin",
      modules ? [ ],
    }:
    let
      specialArgs = mkSpecialArgs { inherit username hostname; };
    in
    nixpkgs.lib.nixosSystem {
      inherit system specialArgs;
      modules = [
        ../modules/nixos
        home-manager.nixosModules.home-manager
        (homeManagerConfig {
          inherit specialArgs username;
          platform = "linux";
        })
      ]
      ++ modules;
    };
}
