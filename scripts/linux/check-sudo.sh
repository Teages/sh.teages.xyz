#!/bin/bash

# check if sudo exists
if command -v sudo &> /dev/null
then
  echo "sudo exists"
else
  echo "sudo does not exist"
fi

# check if current user is root
if [ "$EUID" -ne 0 ]
then
  echo "sudo not found, please run as root to install sudo."
fi

# install sudo
if command -v apt &> /dev/null
then
  apt update && apt install -y sudo

elif command -v yum &> /dev/null
then
  yum update -y && yum install sudo -y

elif command -v dnf &> /dev/null
then
  dnf update -y && dnf install sudo -y

elif command -v pacman &> /dev/null
then
  pacman -Syu && pacman -S sudo --noconfirm

elif command -v zypper &> /dev/null
then
  zypper refresh && zypper install sudo -y

else
  echo "Package manager not supported, please install sudo manually."
  exit 1
fi

# check if sudo is installed
if command -v sudo &> /dev/null
then
  echo "sudo installed successfully"
else
  echo "sudo installation failed"
  exit 1
fi
