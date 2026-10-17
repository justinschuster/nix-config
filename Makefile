SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := help

HOST ?= Bacchus
NIX_FLAGS := --extra-experimental-features 'nix-command flakes'

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
	nix build ".#darwinConfigurations.$(HOST).system" $(NIX_FLAGS)

deploy:
	@printf 'Activating configuration for %s...\n' "$(HOST)"
	nix build .#darwinConfigurations.Bacchus.system \
	   --extra-experimental-features 'nix-command flakes'
	sudo -E ./result/sw/bin/darwin-rebuild switch --flake .#Bacchus

