#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set -eu





#
# Repositório dos scripts de instalação e atualização
URL_ETC="https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/"
URL_MYSHELLENV="https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/skel/myShellEnv/"
URL_UPDATE="https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/"



#
# prepara o diretório temporário
# e efetua o download dos scripts básicos para a instalação
rm -R ~/.tmpMyShellEnv
mkdir -p ~/.tmpMyShellEnv

ISOK=1
INSTALL_FILES=(
  "alertUser.sh" "errorAlert.sh"
  "waitUser.sh" "promptUser.sh" "setIMessage.sh"
)
INTERFACE_URL="${URL_MYSHELLENV}functions/interface/"


if [ ! -d "~/.tmpMyShellEnv" ]; then
  ISOK=0
  printf "Não foi possível criar o diretório temporário de instalação. \n"
  printf "Esta ação foi encerrada.\n"
else

  curl -o "~/.tmpMyShellEnv/textColors.sh" "${URL_MYSHELLENV}textColors.sh"
  if [ ! -f "~/.tmpMyShellEnv/textColors.sh" ]; then
    ISOK=0
    printf "Não foi possível fazer o download do arquivo de instalação 'textColors.sh'\n"
    printf "Esta ação foi encerrada.\n"
  else

    curl -o "~/.tmpMyShellEnv/downloadMyShellEnvScript.sh" "${URL_MYSHELLENV}functions/downloadMyShellEnvScript.sh"
    if [ ! -f "~/.tmpMyShellEnv/downloadMyShellEnvScript.sh" ]; then
      ISOK=0
      printf "Não foi possível fazer o download do arquivo de instalação 'downloadMyShellEnvScript.sh'\n"
      printf "Esta ação foi encerrada.\n"
    else

      curl -o "~/.tmpMyShellEnv/installMyShellEnvScripts.sh" "${URL_MYSHELLENV}functions/installMyShellEnvScripts.sh"
      if [ ! -f "~/.tmpMyShellEnv/installMyShellEnvScripts.sh" ]; then
        ISOK=0
        printf "Não foi possível fazer o download do arquivo de instalação 'installMyShellEnvScripts.sh'\n"
        printf "Esta ação foi encerrada.\n"
      else
        for fileName in "${INSTALL_FILES[@]}"; do
          if [ $ISOK == 1 ]; then
            curl -o "~/.tmpMyShellEnv/${fileName}" "${INTERFACE_URL}${fileName}"
            if [ ! -f "~/.tmpMyShellEnv/${fileName}" ]; then
              ISOK=0
              printf "Não foi possível fazer o download do arquivo de instalação '${fileName}'\n"
              printf "Esta ação foi encerrada.\n"
            fi
          fi
        done
      fi
    fi

  fi
fi





#
# Tendo conseguido carregar todos os arquivos necessários para a instalação
# prossegue com a instalação
if [ $ISOK == 1 ]; then
  source ~/.tmpMyShellEnv/textColors.sh
  source ~/.tmpMyShellEnv/downloadMyShellEnvScript.sh
  source ~/.tmpMyShellEnv/installMyShellEnvScripts.sh

  for fileName in "${INSTALL_FILES[@]}"; do
    source "~/.tmpMyShellEnv/${fileName}"
  done



  clear
  setIMessage "" 1
  setIMessage "${SILVER}myShellEnv v 0.9.5 [2021-08-28]${NONE}"
  setIMessage "Iniciando o processo de instalação."
  alertUser


  INSTALL_IN_SKEL=0
  INSTALL_LOGIN_MESSAGE=0
  INSTALL_IN_MY_USER=0



  #
  # sendo um root
  if [ "$EUID" == 0 ]; then
    setIMessage "" 1
    setIMessage "Você foi identificado como um usuário com privilégios ${LBLUE}root${NONE}"
    setIMessage "Isto significa que você tem permissão para instalar o ${LBLUE}myShellEnv${NONE}"
    setIMessage "para ${SILVER}todo novo usuário${NONE} criado nesta máquina."
    alertUser

    setIMessage "\n" 1
    setIMessage "Você deseja fazer uma instalação global (${LBLUE}skel${NONE})?"
    setIMessage "[ ${DGREY}Usuários existentes não serão alterados!${NONE} ]"

    promptUser
    INSTALL_IN_SKEL=$PROMPT_RESULT
    PROMPT_RESULT=""


    setIMessage "\n" 1
    setIMessage "Você deseja instalar a mensagem de login?"
    setIMessage "[ ${DGREY}Ela será vista por todos os usuários!${NONE} ]"

    promptUser
    INSTALL_LOGIN_MESSAGE=$PROMPT_RESULT
    PROMPT_RESULT=""
  fi





  #
  # Verifica se é para efetuar a instalação do 'myShellEnv' para o usuário atual.
  setIMessage "\n" 1
  setIMessage "Prosseguir instalação para o seu próprio usuário?"

  promptUser
  INSTALL_IN_MY_USER=$PROMPT_RESULT
  PROMPT_RESULT=""





  #
  # Sendo para instalar no skel...
  if [ "$INSTALL_IN_SKEL" == "1" ]; then
    installMyShellEnvScripts 1

    setIMessage "" 1
    setIMessage "${SILVER}Instalação no skel concluída${NONE}"
    alertUser
  fi



  #
  # Sendo para instalar a mensagem de login...
  if [ "$INSTALL_LOGIN_MESSAGE" == "1" ]; then
    curl -s -o /etc/issue "${URL_ETC}issue"

    setIMessage "" 1
    setIMessage "${SILVER}Instalação da mensagem de login concluída${NONE}"
    alertUser
  fi



  #
  # Sendo para instalar no skel...
  if [ "$INSTALL_IN_SKEL" == "1" ]; then
    installMyShellEnvScripts 0

    setIMessage "" 1
    setIMessage "${SILVER}Instalação para o seu usuário concluída${NONE}"
    alertUser
  fi



  #
  # Encerra o script
  setIMessage "" 1
  setIMessage "${SILVER}Processo de instalação encerrado!${NONE}"
  if [ "$INSTALL_IN_MY_USER" == "1" ]; then
    setIMessage "As atualizações serão carregadas no próximo login."
  fi
  setIMessage ""


  rm installMyShellEnv.sh || true
  rm -R -/.tmpMyShellEnv
  waitUser
fi
