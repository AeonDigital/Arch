#!/bin/bash

setNewUser() {
  useradd -m -g users -G wheel $1
  echo $1 ALL=(ALL) ALL >> /etc/sudoers
  passwd $1
  cp /home/.bash_profile /home/$1/
  cp /home/.bashrc /home/$1/
}
