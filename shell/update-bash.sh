#!/bin/bash

# Efetua o download dos novos arquivos
curl -o /etc/issue https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/issue

curl -o /etc/myBashEnvironment/variables.sh https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/myBashEnvironment/variables.sh
curl -o /etc/myBashEnvironment/thirdp_functions_pallete256.sh https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/myBashEnvironment/thirdp_functions_pallete256.sh
curl -o /etc/myBashEnvironment/functions.sh https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/myBashEnvironment/functions.sh

curl -o /etc/skel/myBashConfig/aliases.sh https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/skel/myBashConfig/aliases.sh
curl -o /etc/skel/myBashConfig/prompt.sh https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/skel/myBashConfig/prompt.sh
curl -o /etc/skel/myBashConfig/functions.sh https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/skel/myBashConfig/functions.sh

curl -o /etc/skel/.bash_profile https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/skel/.bash_profile
curl -o /etc/skel/.bashrc https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/skel/.bashrc
