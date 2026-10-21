# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

A nix-darwin / NixOS + Home Manager flake, structured for multiple hosts. Currently there is one host, `Bacchus` (nix-darwin, user `justin`, `aarch64-darwin`); no NixOS hosts exist yet but the plumbing for them does. Nixpkgs, nix-darwin and Home Manager are all pinned to the 26.05 release branches: `nixpkgs` (nixos-26.05) is used for NixOS hosts and the formatter, `nixpkgs-darwin` for darwin hosts. `nixpkgs-unstable` is also an input.

## Commands

- `make install-deps` — run `scripts/init.sh` (installs Homebrew on macOS, clones `config.nvim` into `~/src/config.nvim`). Must be run before the first build.
- `make build [HOST=Bacchus]` — build the host without activating. Uses `darwinConfigurations.$(HOST).system` on macOS and `nixosConfigurations.$(HOST).config.system.build.toplevel` on Linux (chosen by `uname -s`).
- `make deploy [HOST=Bacchus]` — builds then activates with `darwin-rebuild switch` (macOS) or `nixos-rebuild switch` (Linux).
- `nix fmt` — formats Nix with `nixfmt` (the flake's `formatter`, defined for aarch64-darwin, x86_64-linux and aarch64-linux).

There are no tests. New files must be `git add`ed before the flake can see them.

## Architecture

`flake.nix` only lists inputs and hosts. Each host is one call to a helper from `lib/default.nix`:

- `mkDarwinSystem { hostname, system, username ? "justin", modules ? [] }` — `modules/darwin` + nix-homebrew + Home Manager with `home/common` and `home/darwin`.
- `mkNixosSystem { ... }` (same args) — `modules/nixos` + Home Manager with `home/common` and `home/linux`.

Both pass `inputs // { username, hostname }` as `specialArgs` (and as Home Manager `extraSpecialArgs`), so modules take `username`/`hostname` as arguments rather than hardcoding.

- `hosts/<name>/` — host-only settings (for Bacchus: `system.stateVersion`, macOS defaults, TouchID sudo).
- `modules/common/` — shared by every host: `nix.settings` (flakes, substituters, trusted-users) and system packages / `allowUnfree`.
- `modules/darwin/` — every macOS host: `nix.enable = false` (Determinate), users/hostname, Homebrew, zsh. `homebrew.nix` uses cleanup mode `zap`, so anything installed with Homebrew but not listed there is removed on activation.
- `modules/nixos/` — every NixOS host: hostname, a normal `wheel` user with zsh.
- `home/common/` — cross-platform Home Manager config (`core.nix` packages/session vars/nvim symlink, `shell.nix` zsh). `homeDirectory` is picked via `pkgs.stdenv.isDarwin`.
- `home/darwin/`, `home/linux/` — platform-only Home Manager config (e.g. ghostty uses `ghostty-bin` on macOS, `ghostty` on Linux; Homebrew shellenv is macOS-only).

To add a host: create `hosts/<name>/default.nix` (for NixOS, import its `hardware-configuration.nix` and set `system.stateVersion`), then add it to `darwinConfigurations` or `nixosConfigurations` in `flake.nix` (there is a commented NixOS example).

The Neovim config is not in this repo. It lives in `~/src/config.nvim` (cloned by `scripts/init.sh`) and `home/common/core.nix` symlinks it to `~/.config/nvim` with `mkOutOfStoreSymlink`, so edits there take effect without a rebuild. The `nvim-config` flake input exists but the symlink is what's actually used. `.gitmodules` references a stale `config/nvim` submodule that is not present.
