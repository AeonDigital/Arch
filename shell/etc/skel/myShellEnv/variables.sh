#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





#
# Informações do sistema
KERNEL=`uname -r`
ARCH=`uname -m`
CPU=`awk -F '[ :][ :]+' '/^model name/ { print $2; exit; }' /proc/cpuinfo`

MEMORY1=`free -t -m | grep "Mem" | awk '{print $6" MB";}'`
MEMORY2=`free -t -m | grep "Mem" | awk '{print $2" MB";}'`
MEMPERCENT=`free | awk '/Mem/{printf("%.2f% (Used) "), $3/$2*100}'`

DETECTDISK=`mount -v | fgrep 'on / ' | sed -n 's_^\(/dev/[^ ]*\) .*$_\1_p'`
DISC=`df -h | grep $DETECTDISK | awk '{print $5 }'`

UP=`uptime -p`
PACMAN=`checkupdates | wc -l`
HOSTNAME=`uname -n`



#
# Configuração do bash
HISTCONTROL=ignoreboth
HISTSIZE=256
HISTTIMEFORMAT="%d/%m/%y %T "



#
# Repositório dos scripts
URL_ETC="https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/"
URL_MYSHELLENV="https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/skel/myShellEnv/"




#
# Data e hora
NOW=$(date +"%Y-%m-%d %T")
NOWD=$(date +"%Y-%m-%d")
NOWT=$(date +"%T")



#
# Definição de cores para uso em strings
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
# echo -e "This text is ${RED}red${NONE} and ${GREEN}green${NONE} and
#    ${BOLD}bold${NONE} and ${UNDERLINE}underlined${NONE}."
