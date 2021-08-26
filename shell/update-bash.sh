#!/bin/bash

# Efetua o download dos novos arquivos
curl -o /etc/issue https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/issue

curl -o /etc/myBashEnvironment/01_variables.sh https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/myBashEnvironment/01_variables.sh
curl -o /etc/bash_env_02_functions.sh https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/bash_env_02_functions.sh
curl -o /etc/bash_env_02_functions_pallete256.sh https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/bash_env_02_functions_pallete256.sh

curl -o /etc/bash_users_aliases.sh https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/bash_users_aliases.sh
curl -o /etc/bash_users_functions.sh https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/bash_users_functions.sh
curl -o /etc/bash_users_prompt.sh https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/bash_users_prompt.sh

curl -o /etc/skel/.bash_profile https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/skel/.bash_profile
curl -o /etc/skel/.bashrc https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/skel/.bashrc
