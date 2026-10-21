# nix-config

nix-darwin / NixOS + Home Manager configuration for all my machines.

## Deps

1. Must run `scripts/init.sh` (`make install-deps`) first. This installs Homebrew (macOS only) and downloads the Neovim configuration.

## Usage

- `make build [HOST=Bacchus]` — build a host's configuration.
- `make deploy [HOST=Bacchus]` — build and activate it (`darwin-rebuild` on macOS, `nixos-rebuild` on Linux).

## Layout

```
flake.nix          # inputs + one entry per host
lib/               # mkDarwinSystem / mkNixosSystem helpers
hosts/<name>/      # host-specific settings
modules/common/    # system config shared by every host
modules/darwin/    # system config for every macOS host (incl. Homebrew)
modules/nixos/     # system config for every NixOS host
home/common/       # Home Manager config for every host
home/darwin/       # Home Manager config for macOS only
home/linux/        # Home Manager config for Linux only
```

## Adding a host

1. Create `hosts/<name>/default.nix`. For NixOS, copy in the machine's
   `hardware-configuration.nix`, import it, and set `system.stateVersion`.
2. Register it in `flake.nix` under `darwinConfigurations` (`mylib.mkDarwinSystem`) or
   `nixosConfigurations` (`mylib.mkNixosSystem`) with its `hostname`, `system` and
   `modules = [ ./hosts/<name> ]`.
3. `make deploy HOST=<name>` on that machine.
