# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

A nix-darwin + Home Manager flake for a single macOS machine (host `Bacchus`, user `justin`, `aarch64-darwin`). Nixpkgs, nix-darwin and Home Manager are all pinned to the 26.05 release branches; `nixpkgs-unstable` is also an input.

## Commands

- `make install-deps` — run `scripts/init.sh` (installs Homebrew, clones `config.nvim` into `~/src/config.nvim`). Must be run before the first build.
- `make build [HOST=Bacchus]` — `nix build .#darwinConfigurations.$(HOST).system` without activating.
- `make deploy` — builds then activates with `sudo -E ./result/sw/bin/darwin-rebuild switch --flake .#Bacchus`. Note it hardcodes `Bacchus` and ignores `HOST`.
- `nix fmt` — formats Nix with `nixfmt` (the flake's `formatter`).

There are no tests.

## Architecture

`flake.nix` defines the one `darwinConfigurations."Bacchus"`. `username`, `system` and `hostname` are defined in its `let` block and passed to every module through `specialArgs` (including to Home Manager via `extraSpecialArgs`), so modules take them as arguments rather than hardcoding.

- `modules/` — system-level nix-darwin modules (`nix-core`, `system`, `host-users`, `apps`). `apps.nix` holds system packages and the Homebrew config (via `nix-homebrew`); its cleanup mode is `zap`, so anything installed with Homebrew but not listed there is removed on activation.
- `home/` — Home Manager config for the user, wired in from `flake.nix` as `home-manager.users.${username} = import ./home`. `default.nix` imports `core.nix` (packages, session vars, nvim symlink) and `shell.nix`.

The Neovim config is not in this repo. It lives in `~/src/config.nvim` (cloned by `scripts/init.sh`) and `home/core.nix` symlinks it to `~/.config/nvim` with `mkOutOfStoreSymlink`, so edits there take effect without a rebuild. The `nvim-config` flake input exists but the symlink is what's actually used. `.gitmodules` references a stale `config/nvim` submodule that is not present.
