# Useful nixos commands

# Use fish for shell commands
# set shell := ["fish", "-c"]

# Print available commands by default
default:
    @just --list --unsorted --justfile {{justfile()}}

# Deploy the system config
deploy:
    nixos-rebuild switch --flake .

# Deploy the system config with debug flags
debug:
    nixos-rebuild switch --flake . --show-trace --verbose

# Update flake
update:
    nix flake update

# Show the history of the system
history:
	nix profile history --profile /nix/var/nix/profiles/system

# Remove all generations older than 7 days
clean:
	sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

# Garbage collect all unused nix store entries
gc:
	sudo nix store gc --debug

# Enter the Nix REPL
repl:
  nix repl -f ./flake.nix

# Run the Nix formatter
fmt:
	nix fmt
