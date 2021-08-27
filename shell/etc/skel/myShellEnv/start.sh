#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e
clear
timedatectl set-timezone America/Sao_Paulo



#
# Prompt padrão
PS1="\[\e[40;00;37m\]\$ \[\e[40;01;30m\]\u\[\e[40;00;37m\]@\[\e[40;01;30m\]\h : \[\e[40;00;37m\]"
MYSHELLENV_START=0



#
# Se $USER está definido...
if [ "$USER" != "" ]; then
  MYSHELLENV_START=1
  source ~/myShellEnv/interface.sh || true



  #
  # Dá a chance de usuários 'root' optarem por
  # carregar ou não o 'myShellEnv'.
  #
  if [ "$EUID" == 0 ]; then
    PROMPT_MSG[0]=$(printf "${SILVER}Deseja iniciar o myShellEnv?${NONE}")

    promptUser
    MYSHELLENV_START=${PROMPT_RESULT}
    PROMPT_RESULT=""
  fi
fi





#
# Conforme processamento anterior
# carrega o restante dos scripts
#
if [ "$MYSHELLENV_START" == 1 ]; then
  source ~/myShellEnv/variables.sh || true
  source ~/myShellEnv/aliases.sh || true
  source ~/myShellEnv/prompt.sh || true
  source ~/myShellEnv/functions.sh || true

  PS1=$PSTYLE03D
fi





#
# Apenas se está carregando o 'myShellEnv'
# e está em uma sessão que iniciou por um login
# apresenta a mensagem de entrada.
#
if [ "$MYSHELLENV_START" == 1 ] && [ "$0" == "-bash" ]; then
  echo -e "\e[37m  Arch Linux $KERNEL $ARCH \e[00m
  \e[1;30m
           #####
          #######
           #####\e[00m                  CPU: \e[1;34m$CPU\e[00m
                               Memory: \e[1;34m$MEMORY1 / $MEMORY2 - $MEMPERCENT\e[00m\e[1;30m
   #####   #####\e[00m             Use Disk: \e[1;34m$DISC (used)\e[00m\e[1;30m
  ####### #######\e[00m              Uptime: \e[1;34m$UP\e[00m\e[1;30m
   #####   #####\e[00m               Pacman: \e[1;34m$PACMAN packages can be updated\e[00m\e[1;30m

   #####           #####\e[00m         User: \e[1;34m$USER\e[00m\e[1;30m
  #######         #######\e[00m        Host: \e[1;34m$HOSTNAME\e[00m\e[1;30m
   #####           #####\e[00m         Date: \e[1;34m$NOW\e[00m

  "
fi
