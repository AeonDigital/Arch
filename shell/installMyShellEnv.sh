#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set -eu





#
# Repositório dos scripts de instalação e atualização
URL_ETC="https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/"
URL_MYSHELLENV="https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/skel/myShellEnv/"
URL_UPDATE="https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/"


ISOK=1



#
# Efetua o download de scripts necessários para a instalação
# Em caso de falha, altera o valor da variável de controle ${ISOK} para "0".
# Sendo bem sucedido irá carregar o script.
#
#   @param string $1
#   Nome do script a ser salvo no diretório temporário 'tmpMyShellEnv'.
#
#   @param string $2
#   Url onde está o arquivo a ser baixado.
#
#   @example
#     downloadInstallScripts "textColors.sh" "textColors.sh"
#
downloadInstallScripts() {
  if [ $# != 2 ]; then
    printf "ERROR in ${FUNCNAME[0]}: expected 2 arguments"
  else
    TMP="${HOME}/tmpMyShellEnv/$1"
    curl -s -o "${TMP}" "$2" || true

    if [ ! -f "$TMP" ]; then
      ISOK=0
      printf "Não foi possível fazer o download do arquivo de instalação '$1'\n"
      printf "Esta ação foi encerrada.\n"
      printf "URL: $2 \n"
      printf "TGT: ${TMP} \n"
    fi
  fi
}





#
# prepara o diretório temporário
# e efetua o download dos scripts básicos para a instalação
mkdir -p "${HOME}/tmpMyShellEnv"


if [ ! -d "${HOME}/tmpMyShellEnv" ]; then
  ISOK=0
  printf "Não foi possível criar o diretório temporário de instalação. \n"
  printf "Esta ação foi encerrada.\n"
else

  if [ $ISOK == 1 ]; then
    downloadInstallScripts "textColors.sh" "${URL_MYSHELLENV}textColors.sh"
  fi

  if [ $ISOK == 1 ]; then
    downloadInstallScripts "downloadMyShellEnvScript.sh" "${URL_MYSHELLENV}functions/downloadMyShellEnvScript.sh"
  fi

  if [ $ISOK == 1 ]; then
    downloadInstallScripts "installMyShellEnvScripts.sh" "${URL_MYSHELLENV}functions/installMyShellEnvScripts.sh"
  fi


  if [ $ISOK == 1 ]; then
    INSTALL_FILES=(
      "alertUser.sh" "errorAlert.sh"
      "waitUser.sh" "promptUser.sh" "setIMessage.sh"
    )


    for fileName in "${INSTALL_FILES[@]}"; do
      if [ $ISOK == 1 ]; then
        downloadInstallScripts "${fileName}" "${URL_MYSHELLENV}functions/interface/${fileName}"
      fi
    done
  fi
fi





#
# Tendo conseguido carregar todos os arquivos necessários para a instalação
# prossegue com a instalação
if [ $ISOK == 1 ]; then


  INSTALL_FILES=(
    "textColors.sh" "downloadMyShellEnvScript.sh" "installMyShellEnvScripts.sh"
      "alertUser.sh" "errorAlert.sh" "waitUser.sh" "promptUser.sh" "setIMessage.sh"
  )

  for fileName in "${INSTALL_FILES[@]}"; do
    source "${HOME}/tmpMyShellEnv/${fileName}"
  done





  clear
  setIMessage "" 1
  setIMessage "${SILVER}myShellEnv v 0.9.8 [2021-08-29]${NONE}"
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
    setIMessage "Você deseja instalar a mensagem de login?"
    setIMessage "[ ${DGREY}Ela será vista por todos os usuários!${NONE} ]"

    promptUser
    INSTALL_LOGIN_MESSAGE=$PROMPT_RESULT
    PROMPT_RESULT=""


    setIMessage "\n" 1
    setIMessage "Você deseja fazer uma instalação global (${LBLUE}skel${NONE})?"
    setIMessage "[ ${DGREY}Usuários existentes não serão alterados!${NONE} ]"

    promptUser
    INSTALL_IN_SKEL=$PROMPT_RESULT
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
  # Sendo para instalar a mensagem de login...
  if [ "$INSTALL_LOGIN_MESSAGE" == "1" ]; then
    if [ -f "/etc/issue" ]; then
      cp /etc/issue /etc/issue_beforeMyShellEnv
    fi
    curl -s -o /etc/issue "${URL_ETC}issue" || true

    if [ ! -f "/etc/issue" ]; then
      setIMessage "" 1
      setIMessage "Não foi possível instalar a mensagem de login"
      setIMessage "Processo abortado."
    else
      setIMessage "" 1
      setIMessage "${SILVER}Instalação da mensagem de login concluída${NONE}"
      alertUser
    fi
  fi





  #
  # Sendo para instalar no skel...
  if [ "$INSTALL_IN_SKEL" == "1" ]; then
    mkdir -p "/etc/skel/myShellEnv"
    if [ ! -d "/etc/skel/myShellEnv" ]; then
      setIMessage "\n" 1
      setIMessage "Não foi possível criar o diretório ${LBLUE}/etc/skel/myShellEnv${NONE}?"
      setIMessage "Esta ação foi encerrada.\n"
      alertUser
    else
      installMyShellEnvScripts 1

      if [ $ISOK == 1 ]; then
        setIMessage "" 1
        setIMessage "${SILVER}Instalação no skel concluída${NONE}"
        alertUser
      fi
    fi
  fi





  #
  # Sendo para instalar no no usuário atual...
  if [ "$INSTALL_IN_MY_USER" == "1" ]; then
    mkdir -p "${HOME}/myShellEnv"
    if [ ! -d "${HOME}/myShellEnv" ]; then
      setIMessage "\n" 1
      setIMessage "Não foi possível criar o diretório ${LBLUE}${HOME}/myShellEnv${NONE}?"
      setIMessage "Esta ação foi encerrada.\n"
      alertUser
    else
      installMyShellEnvScripts 0

      if [ $ISOK == 1 ]; then
        setIMessage "" 1
        setIMessage "${SILVER}Instalação para o seu usuário concluída${NONE}"
        alertUser
      fi
    fi
  fi





  #
  # Encerra o script
  setIMessage "" 1
  setIMessage "${SILVER}Processo de instalação encerrado!${NONE}"
  if [ "$INSTALL_IN_MY_USER" == "1" ]; then
    setIMessage "As atualizações serão carregadas no próximo login."
  fi
  setIMessage ""


  rm -R "${HOME}/tmpMyShellEnv"
  rm installMyShellEnv.sh
  waitUser
fi
