# Useful nixos commands

# Use fish for shell commands
# set shell := ["fish", "-c"]

# Print available commands by default
default:
    @just --list --unsorted --justfile {{justfile()}}


# Build the live ISO for provisioning
build-iso:
    nix build --impure .#nixosConfigurations.live.config.system.build.isoImage
    @echo "ISO at $(find result/iso -name '*.iso')"

# Deploy the system config
deploy:
    nh os switch . --ask -- --impure

# Build a node config with debug flags
build:
    nh os build . -- --show-trace --verbose

# Update flake
update:
    nix flake update

# Update flake input
update-input input:
    nix flake update {{input}}

# Show the history of the system
history:
    nix profile history --profile /nix/var/nix/profiles/system

# Remove all generations older than 7 days
clean:
    sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

# Garbage collect all unused nix store entries
gc:
    sudo nix store gc --debug

# Run the Nix formatter
fmt:
    alejandra *
