#!/bin/bash

# Efetua o download dos novos arquivos
curl -o /etc/issue https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/issue

curl -o /etc/bash-aliases.sh https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/bash-aliases.sh
curl -o /etc/bash-function-pallete256.sh https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/bash-function-pallete256.sh
curl -o /etc/bash-function-user.sh https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/bash-function-user.sh
curl -o /etc/bash-message-wellcome-01 https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/bash-message-wellcome-01
curl -o /etc/bash-message-wellcome-02 https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/bash-message-wellcome-02
curl -o /etc/bash-prompt.sh https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/bash-prompt.sh
curl -o /etc/bash-variables.sh https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/bash-variables.sh

curl -o /etc/skel/.bash_profile https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/skel/.bash_profile
curl -o /etc/skel/.bashrc https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/skel/.bashrc