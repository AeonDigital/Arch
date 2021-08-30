#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





#
# Efetua a instalação dos scripts básicos para o funcionamento
# do 'myShellEnv'
#
#   @param bool $1
#   Use '1' para instalar os scripts no 'skel' ou '0' para
#   instalar no ambiente do usuário atualmente logado.
#
installMyShellEnvScripts() {
  if [ $# != 1 ]; then
    errorAlert "${FUNCNAME[0]}" "expected 1 arguments"
  else

    IS_SKEL=0
    if [ $1 == 1 ] || [ $1 == 0 ]; then
      IS_SKEL=$1
    fi

    TARGET_DIR="${HOME}/myShellEnv/"
    if [ $IS_SKEL == 1 ]; then
      TARGET_DIR="/etc/skel/myShellEnv/"
    fi


    # Diretório e arquivos básicos
    if [ $ISOK == 1 ]; then
      TARGET_FILES=("aliases.sh" "start.sh" "textColors.sh")
      downloadMyShellEnvScript "$URL_MYSHELLENV" "$TARGET_DIR"
    fi


    # Funções
    if [ $ISOK == 1 ]; then
      FN_DIR="${TARGET_DIR}functions/"
      FN_URL="${URL_MYSHELLENV}functions/"
      TARGET_FILES=("downloadMyShellEnvScript.sh" "installMyShellEnvScripts.sh" "uninstallMyShellEnv.sh")
      downloadMyShellEnvScript "$FN_URL" "$FN_DIR"
    fi


    # Funções :: interface
    if [ $ISOK == 1 ]; then
      FN_DIR="${TARGET_DIR}functions/interface/"
      FN_URL="${URL_MYSHELLENV}functions/interface/"
      TARGET_FILES=("alertUser.sh" "errorAlert.sh" "promptUser.sh" "setIMessage.sh" "waitUser.sh")
      downloadMyShellEnvScript "$FN_URL" "$FN_DIR"
    fi


    # Funções :: string
    if [ $ISOK == 1 ]; then
      FN_DIR="${TARGET_DIR}functions/string/"
      FN_URL="${URL_MYSHELLENV}functions/string/"
      TARGET_FILES=(
        "toLowerCase.sh" "toUpperCase.sh"
        "trim.sh" "trimD.sh" "trimDL.sh" "trimDR.sh" "trimL.sh" "trimR.sh"
      )
      downloadMyShellEnvScript "$FN_URL" "$FN_DIR"
    fi


    # Funções :: terminal
    if [ $ISOK == 1 ]; then
      FN_DIR="${TARGET_DIR}functions/terminal/"
      FN_URL="${URL_MYSHELLENV}functions/terminal/"
      TARGET_FILES=("setUTF8.sh" "showPromptOptions.sh" "showScreenColors.sh" "showTextColors.sh")
      downloadMyShellEnvScript "$FN_URL" "$FN_DIR"
    fi


    # Funções :: thirdPart
    if [ $ISOK == 1 ]; then
      FN_DIR="${TARGET_DIR}functions/thirdPart/"
      FN_URL="${URL_MYSHELLENV}functions/thirdPart/"
      TARGET_FILES=("print256colours.sh")
      downloadMyShellEnvScript "$FN_URL" "$FN_DIR"
    fi


    # prompts
    if [ $ISOK == 1 ]; then
      FN_DIR="${TARGET_DIR}prompts/"
      FN_URL="${URL_MYSHELLENV}prompts/"
      TARGET_FILES=("prompt.sh")
      downloadMyShellEnvScript "$FN_URL" "$FN_DIR"
    fi
  fi
}
