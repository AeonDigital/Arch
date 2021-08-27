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
PACMAN=`checkupdates | wc -l 2>/dev/null`
HOSTNAME=`uname -n`



#
# Configuração do bash
HISTCONTROL=ignoreboth
HISTSIZE=256
HISTTIMEFORMAT="%d/%m/%y %T "



#
# Data e hora
NOW=$(date +"%Y-%m-%d %T")
NOWD=$(date +"%Y-%m-%d")
NOWT=$(date +"%T")
