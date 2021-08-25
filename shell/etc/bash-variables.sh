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

BLACK="\e[00;30m"
DGREY="\e[01;30m"
WHITE="\e[00;37m"
SILVER="\e[01;37m"

RED="\e[00;31m"
LRED="\e[01;31m"

GREEN="\e[00;32m"
LGREEN="\e[01;32m"

BROWN="\e[00;33m"
YELLOW="\e[01;33m"

BLUE="\e[00;34m"
LBLUE="\e[01;34m"

PURPLE="\e[00;35m"
LPURPLE="\e[01;35m"

CYAN="\e[00;36m"
LCYAN="\e[01;36m"



## Atributo de fonte
BOLD="\e[01m"
UNDERLINE="\e[03m"
BLINK="\e[05m"


# Exemplo de uso
# echo -e "This text is ${RED}red${NONE} and ${GREEN}green${NONE} and ${BOLD}bold${NONE} and ${UNDERLINE}underlined${NONE}."

AEONGIT="https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/"
