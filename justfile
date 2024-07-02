_default:
  just --list --unsorted

# update channels
update:
    sudo nix-channel --update

# copy .nix files in /etc/nixos and launch test
test:
    sudo cp *.nix /etc/nixos
    sudo nixos-rebuild test

# switch on new derivation
switch:
    sudo nixos-rebuild switch

# purge old derivations
garbage:
    sudo nix-collect-garbage
