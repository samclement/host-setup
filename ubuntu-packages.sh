#!/bin/bash
set -e

# Update and install packages
sudo apt-get update && sudo apt-get install -y fish git mosh tmux unzip openssh-server chromium-browser curl

# Install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Get latest stable neovim 
sudo add-apt-repository ppa:neovim-ppa/stable -y
sudo apt-get update -y
sudo apt-get install -y neovim

