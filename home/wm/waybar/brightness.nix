{ pkgs, ... }:
pkgs.writers.writePython3Bin "waybar-brightness" {
    libraries = with pkgs; [
        brightnessctl
    ];
} ''
import os
import sys
import subprocess

cur_bright = int(
    subprocess.check_output("brightnessctl g", shell=True, text=True))
max_bright = int(
    subprocess.check_output("brightnessctl m", shell=True, text=True))
percents = round(cur_bright * 100 / max_bright)

if sys.argv[1] == "get":
    print(f" {percents}%")
if sys.argv[1] == "lower":
    os.system(f"brightnessctl s {percents-5}%")
if sys.argv[1] == "raise":
    os.system(f"brightnessctl s {percents+5}%")
''
