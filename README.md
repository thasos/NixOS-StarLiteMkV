# NixOS for StarLabs StarLite Mk V

Base Nix configuration that work for this Surface like PC/Tablet.

For now, everything works out of the box except the screen rotation.

I made it functional but it needs more improvements : sometime (rarely) it boots upside down.

DO NOT PASTE THESES FILES, it needs some adjustments (disk uuid, locales, ...)

Tips : I use [just](https://github.com/casey/just) (a command runner like make) to launch nix main commands (channel update, switch...), it uses the `justfile`

⚠ Don't hesitate to submit PR ! 😃
