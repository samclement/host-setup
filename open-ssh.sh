#!/bin/bash

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root. Use sudo." >&2
    exit 1
fi

# Install OpenSSH if not already installed
echo "Installing OpenSSH..."
if ! command -v sshd >/dev/null 2>&1; then
    apt-get update && apt-get install -y openssh-server
else
    echo "OpenSSH is already installed."
fi

# Start and enable OpenSSH service
echo "Starting and enabling OpenSSH service..."
systemctl start ssh
systemctl enable ssh

# Fetch public keys from the specified GitHub user
GITHUB_USER="samclement"
AUTHORIZED_KEYS_FILE="/root/.ssh/authorized_keys"

echo "Fetching public keys from GitHub user: $GITHUB_USER..."
mkdir -p /root/.ssh
curl -s "https://github.com/$GITHUB_USER.keys" >> "$AUTHORIZED_KEYS_FILE"

# Set correct permissions
echo "Setting permissions on .ssh and authorized_keys..."
chmod 700 /root/.ssh
chmod 600 "$AUTHORIZED_KEYS_FILE"

# Verify keys are added
if [[ -s $AUTHORIZED_KEYS_FILE ]]; then
    echo "Public keys successfully added to $AUTHORIZED_KEYS_FILE."
else
    echo "No keys were fetched. Verify the GitHub username or network connection." >&2
    exit 1
fi

echo "OpenSSH setup and key import complete."
