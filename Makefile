SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := help

HOST ?= Bacchus
NIX_FLAGS := --extra-experimental-features 'nix-command flakes'

ifeq ($(shell uname -s),Darwin)
  FLAKE_ATTR := darwinConfigurations.$(HOST).system
  SWITCH := sudo -E ./result/sw/bin/darwin-rebuild switch --flake .\#$(HOST)
else
  FLAKE_ATTR := nixosConfigurations.$(HOST).config.system.build.toplevel
  SWITCH := sudo nixos-rebuild switch --flake .\#$(HOST)
endif

.PHONY: help install-deps build deploy

help:
	@printf '\nUsage: make <target> [HOST=Bacchus]\n\n'
	@awk 'BEGIN {FS = ":.*## "} /^[a-zA-Z_-]+:.*## / {printf "  %-16s %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@printf '\n'

install-deps:
	@printf 'Installing dependencies...\n'
	bash ./scripts/init.sh

build:
	@printf 'Building configuration for %s...\n' "$(HOST)"
	nix build ".#$(FLAKE_ATTR)" $(NIX_FLAGS)

deploy: build
	@printf 'Activating configuration for %s...\n' "$(HOST)"
	$(SWITCH)
