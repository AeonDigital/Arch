#!/bin/bash

# Efetua o download dos novos arquivos
curl -O https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/issue

curl -O https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/bash-aliases.sh
curl -O https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/bash-function-pallete256.sh
curl -O https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/bash-function-user.sh
curl -O https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/bash-message-wellcome-01
curl -O https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/bash-message-wellcome-02
curl -O https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/bash-prompt.sh
curl -O https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/bash-variables.sh

curl -O https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/skel/.bash_profile
curl -O https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/skel/.bashrc


# Move os arquivos baixados para os locais corretos
mv issue /etc/issue

mv bash-aliases.sh /etc/bash-aliases.sh
mv bash-function-pallete256.sh /etc/bash-function-pallete256.sh
mv bash-function-user.sh /etc/bash-function-user.sh
mv bash-message-wellcome-01 /etc/bash-message-wellcome-01
mv bash-message-wellcome-02 /etc/bash-message-wellcome-02
mv bash-prompt.sh /etc/bash-prompt.sh
mv bash-variables.sh /etc/bash-variables.sh

mv .bash_profile /etc/skel/.bash_profile
mv .bashrc /etc/skel/.bashrc
