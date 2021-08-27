#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set -eu





#
# Repositório dos scripts
URL_ETC="https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/"
URL_MYSHELLENV="https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/skel/myShellEnv/"



#
# Confirma a ação do usuário
PROMPT_MSG=()
PROMPT_MSG[0]=""
PROMPT_MSG[1]=$(printf "${SILVER}myShellEnv${NONE}")
PROMPT_MSG[2]=$(printf "Iniciando o processo de atualização para o seu usuário.")
PROMPT_MSG[3]=$(printf "Esta ação não pode ser desfeita.")
PROMPT_MSG[4]=$(printf "Deseja prosseguir?")

promptUser
UPDATE_MY_USER=$PROMPT_RESULT
PROMPT_RESULT=""

if [ "$UPDATE_MY_USER" == "1" ]; then
  mkdir -p ~/myShellEnv

  curl -s -o ~/myShellEnv/aliases.sh "${URL_MYSHELLENV}aliases.sh"
  curl -s -o ~/myShellEnv/interface.sh "${URL_MYSHELLENV}interface.sh"
  curl -s -o ~/myShellEnv/functions.sh "${URL_MYSHELLENV}functions.sh"
  curl -s -o ~/myShellEnv/prompt.sh "${URL_MYSHELLENV}prompt.sh"
  curl -s -o ~/myShellEnv/start.sh "${URL_MYSHELLENV}start.sh"
  curl -s -o ~/myShellEnv/variables.sh "${URL_MYSHELLENV}variables.sh"



  mkdir -p ~/myShellEnv/thirdPartFunctions

  curl -s -o ~/myShellEnv/thirdPartFunctions/print256colours.sh "${URL_MYSHELLENV}thirdPartFunctions/print256colours.sh"


  ALERT_MSG=()
  ALERT_MSG[0]=""
  ALERT_MSG[1]=$(printf "${SILVER}Atualização concluída${NONE}")
  alertUser
fi





#
# Encerra o script
ALERT_MSG=()
ALERT_MSG[0]=$(printf "${SILVER}Processo de atualização encerrado!${NONE}")
ALERT_MSG[1]=""


rm updateMyShellEnv.sh || true
waitUser


if [ "$UPDATE_MY_USER" == "1" ]; then
  source ~/myShellEnv/start.sh || true
fi
