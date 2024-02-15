#!/bin/bash

# Check if the script is run as root
#if [ "$(id -u)" -ne "0" ]; then
#    echo "This script must be run as root" 1>&2
 #   exit 1
#fi

# Prompt for current username
#read -p "Enter the current username: " old_username

# Prompt for new username
#read -p "Enter the new username: " new_username

# Check if the new username already exists
#if id "$new_username" &>/dev/null; then
  #  echo "Error: The username $new_username already exists." 1>&2
   # exit 1
#fi
#fi

# Prompt for current username
read -p "Enter the current username: " old_username

# Prompt for new username
read -p "Enter the new username: " new_username

# Check if the new username already exists
if id "$new_username" &>/dev/null; then
    echo "Error: The username $new_username already exists." 1>&2
    exit 1
fi

# Change the username
usermod -l "$new_username" "$old_username"

# Prompt for new hostname
read -p "Enter the new hostname (laptop name): " new_hostname

# Change the username
usermod -l "$new_username" "$old_username"

# Rename home directory
usermod -d "/home/$new_username" -m "$new_username"

# Set the hostname
hostnamectl set-hostname "$new_hostname"

# Update /etc/hosts
sed -i "s/127.0.1.1.*/127.0.1.1\t$new_hostname/g" /etc/hosts
echo "Username has been changed from $old_username to $new_username"
echo "Hostname (laptop name) has been set to $new_hostname"
rm -rf ~/.config/google-chrome
rm -rf ~/.cache/google-chrome
