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
PROMPT_MSG+=""
PROMPT_MSG+=$(printf "${SILVER}myShellEnv${NONE}")
PROMPT_MSG+=$(printf "Iniciando o processo de atualização para o seu usuário.")
PROMPT_MSG+=$(printf "Esta ação não pode ser desfeita.")
PROMPT_MSG+=$(printf "Deseja prosseguir?")

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
  ALERT_MSG+=""
  ALERT_MSG+=$(printf "${SILVER}Atualização concluída${NONE}")
  alertUser
fi





#
# Encerra o script
ALERT_MSG=()
ALERT_MSG+=$(printf "${SILVER}Processo de atualização encerrado!${NONE}")
ALERT_MSG+=""


rm updateMyShellEnv.sh || true
waitUser


if [ "$UPDATE_MY_USER" == "1" ]; then
  source ~/myShellEnv/start.sh || true
fi







#
# Adiciona uma nova linha de informação no array de mensagem
# genérica ${GENERIC_MSG}
#
#   param string $1 nova linha da mensagem
#   param bool $2 use '1' quando quiser que o array seja reiniciado.
#                 Qualquer outro valor não causará efeitos
#   example
#     result=$(toLowerCase "TEXT")
#
setGenericMessage() {
  if [ "$#" != "1" ] && [ "$#" != "2" ]; then
    echo "Error: expected 1 argument"
  else
    if [ "$#" == "2" ] && [ "$2" == "1" ]; then
      GENERIC_MSG=()
    fi

    l=${#GENERIC_MSG[@]}
    GENERIC_MSG[l]=$1
  fi
}
