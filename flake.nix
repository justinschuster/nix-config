{
  description = "Nix configuration for macOS (nix-darwin) and NixOS hosts";

  ##################################################################################################################
  #
  # Want to know Nix in details? Looking for a beginner-friendly tutorial?
  # Check out https://github.com/ryan4yin/nixos-and-flakes-book !
  #
  ##################################################################################################################

  # This is the standard format for flake.nix. `inputs` are the dependencies of the flake,
  # Each item in `inputs` will be passed as a parameter to the `outputs` function after being pulled and built.
  inputs = {
    # Used by NixOS hosts (and the formatter).
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    # Used by darwin hosts.
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs dependencies.
      # (useGlobalPkgs means each host's own pkgs are used for packages anyway.)
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvim-config = {
      url = "github:justinschuster/config.nvim";
      flake = false;
    };
  };

  # The `outputs` function will return all the build results of the flake.
  # The `@` syntax here is used to alias the attribute set of the inputs's parameter, making it convenient to use inside the function.
  outputs =
    inputs@{ nixpkgs, ... }:
    let
      mylib = import ./lib inputs;
    in
    {
      # Build with `make build HOST=<name>`, activate with `make deploy HOST=<name>`.
      darwinConfigurations = {
        Bacchus = mylib.mkDarwinSystem {
          hostname = "Bacchus";
          system = "aarch64-darwin";
          modules = [ ./hosts/bacchus ];
        };
      };

      nixosConfigurations = {
        # example = mylib.mkNixosSystem {
        #   hostname = "example";
        #   system = "x86_64-linux";
        #   # hosts/example/default.nix should import its hardware-configuration.nix
        #   # and set system.stateVersion.
        #   modules = [ ./hosts/example ];
        # };
      };

      # nix code formatter
      formatter = nixpkgs.lib.genAttrs [
        "aarch64-darwin"
        "x86_64-linux"
        "aarch64-linux"
      ] (system: nixpkgs.legacyPackages.${system}.nixfmt);
    };
}
