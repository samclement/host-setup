#!/bin/bash
set -e

# Create a directory for fonts if it doesn't already exist
mkdir -p ~/.local/share/fonts

# Download and install Nerd Fonts (taking an example font)
cd ~/.local/share/fonts && {
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
  unzip JetBrainsMono.zip
  rm JetBrainsMono.zip
  cd -
}

# Update font cache
fc-cache -fv

