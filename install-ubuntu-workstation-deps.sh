#!/bin/bash
set -e

# Check if device identifier is provided as an argument
if [ -z "$1" ]; then
    echo "Please provide an identifier for this machine as the first argument."
    exit 1
fi

machine=$1

# Update and install packages
sudo apt-get update && sudo apt-get install -y fish git mosh tmux unzip openssh-server chromium-browser curl

# Get latest stable neovim 
sudo add-apt-repository ppa:neovim-ppa/stable -y
sudo apt-get update -y
sudo apt-get install -y neovim

# Install golang
wget https://go.dev/dl/go1.22.2.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.22.2.linux-amd64.tar.gz

# Install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install AWS cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws configure

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

# Create ssh key/pair to add to github public keys
ssh-keygen -t ed25519 -C $machine
eval "$(ssh-agent -s)"

echo "Add to github ssh keys:"
cat ~/.ssh/id_ed25519.pub

echo "Installation and configuration completed. Please restart your terminal."