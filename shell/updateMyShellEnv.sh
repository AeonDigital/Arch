#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set -eu
source ~/myShellEnv/interface.sh || true




#
# Repositório dos scripts
URL_ETC="https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/"
URL_MYSHELLENV="https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/skel/myShellEnv/"
URL_UPDATE="https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/"



#
# Confirma a ação do usuário
setIMessage "\n" 1
setIMessage "${SILVER}myShellEnv v 0.9.1 [2021-08-28]${NONE}"
setIMessage "Iniciando o processo de atualização para o seu usuário."
setIMessage "Esta ação não pode ser desfeita."
setIMessage "Deseja prosseguir?"

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


  setIMessage "" 1
  setIMessage "${SILVER}Atualização concluída${NONE}"
  alertUser
fi





#
# Encerra o script
setIMessage "" 1
setIMessage "${SILVER}Processo de atualização encerrado!${NONE}"



rm updateMyShellEnv.sh || true
waitUser


if [ "$UPDATE_MY_USER" == "1" ]; then
  source ~/myShellEnv/start.sh || true
fi
