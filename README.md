# ProggerX/nixos-config
### My multi-host NixOS configuration: PC (usb ssd), laptops and RPI4 server.
## Tree
- ```flake.nix``` - Working mess with all the hosts and their inputs
- ```hosts``` - host-specific configs, laptops inherit PC's ```configuration.nix``` with some changes
- ```modules``` - my NixOS modules
- ```stylix``` - my stylix config, all hosts use it
- ```home``` - my HM config, server doesn't have HM
## Hardware
- PC - AMD Ryzen 5 2600, NVIDIA GeForce GTX1660 (but system is removable, on Netac Z6S usb ssd, 1TB)
- Laptop - Core i7-4600U, integrated graphics
- ThinkPad X1 Yoga G4 (main laptop) - Core i5-8365U, integrated graphics
- Server - Raspberry Pi 4B, with Netac Z7S usb ssd, 240GB
