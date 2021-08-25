#!/bin/bash



# Configuração do bash
HISTCONTROL=ignoreboth
HISTSIZE=256
HISTTIMEFORMAT="%d/%m/%y %T "



# Definição de variáveis para uso em mensagens coloridas
## Cores
### 'D' indica 'Dark'
### 'L' indica 'Light'

NONE="\e[00m"

BLACK="\e[30m"
DGREY="\e[1;30m"
WHITE="\e[37m"
SILVER="\e[1;37m"

RED="\e[31m"
LRED="\e[1;31m"

GREEN="\e[32m"
LGREEN="\e[1;32m"

BROWN="\e[33m"
YELLOW="\e[1;33m"

BLUE="\e[34m"
LBLUE="\e[1;34m"

PURPLE="\e[35m"
LPURPLE="\e[1;35m"

CYAN="\e[36m"
LCYAN="\e[1;36m"



## Atributo de fonte
BOLD="\e[01m"
UNDERLINE="\e[03m"
BLINK="\e[05m"


# Exemplo de uso
# echo -e "This text is ${RED}red${NONE} and ${GREEN}green${NONE} and ${BOLD}bold${NONE} and ${UNDERLINE}underlined${NONE}."
