# NixOS for StarLabs StarLite Mk V

Base Nix configuration that work for this Surface like PC/Tablet.

For now, everything works out of the box except the screen rotation, see comments in [screen_rotation.nix](./screen_rotation.nix) for explanations.

DO NOT PASTE THESES FILES, it needs some adjustments (disk uuid, locales, ...)

Tips : I use [just](https://github.com/casey/just) (a command runner like make) to launch nix main commands (channel update, switch...), it uses the `justfile`

⚠ Don't hesitate to submit PR ! 😃
