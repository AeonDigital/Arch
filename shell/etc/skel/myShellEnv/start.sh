#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





#
# Prompt padrão
PS1="\[\e[40;00;37m\]\$ \[\e[40;01;30m\]\u\[\e[40;00;37m\]@\[\e[40;01;30m\]\h : \[\e[40;00;37m\]"



if [ "$USER" != "" ]; then
  MYSHELLENV_START=1

  clear
  timedatectl set-timezone America/Sao_Paulo



  #
  # Dá a chance do root optar por carregar ou não os scripts
  # de personalização
  #
  #if [ "$USER" == "root" ]; then
  if [ "$EUID" == 0 ]; then
    PROMPT_MSG[0]=$(printf "\e[01;37mDeseja iniciar o myShellEnv?\e[00m")

    promptUser
    MYSHELLENV_START=${PROMPT_RESULT}
    PROMPT_RESULT=""
  fi



  #
  # Carrega configurações personalizadas
  #
  if [ "$MYSHELLENV_START" == 1 ]; then
    source ~/myShellEnv/variables.sh || true
    source ~/myShellEnv/aliases.sh || true
    source ~/myShellEnv/prompt.sh || true
    source ~/myShellEnv/functions.sh || true

    PS1=$PSTYLE03D
  else
    source ~/myShellEnv/variables.sh || true
  fi





  #
  # Mensagem de Boas Vindas
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