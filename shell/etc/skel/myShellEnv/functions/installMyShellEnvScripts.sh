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
#   instalar no ambiente do usuário atualmente logado
#
installMyShellEnvScripts() {
  if [ $# != 1 ]; then
    errorAlert "${FUNCNAME[0]}" "expected 1 arguments"
  else

    IS_SKEL=0
    if [ $1 == 1 ] || [ $1 == 0 ]; then
      IS_SKEL=$1
    fi

    TARGET_DIR="~/myShellEnv/"
    if [ $IS_SKEL == 1 ]; then
      TARGET_DIR="/etc/skel/myShellEnv/"
    fi


    # Diretório e arquivos básicos
    TARGET_SCRIPTS=("aliases.sh" "start.sh" "textColors.sh")
    downloadMyShellEnvScript "$URL_MYSHELLENV" "$TARGET_DIR"


    # Funções
    FN_DIR="${TARGET_DIR}functions/"
    FN_URL="${URL_MYSHELLENV}functions/"
    TARGET_SCRIPTS=("downloadMyShellEnvScript.sh" "installMyShellEnvScripts.sh")
    downloadMyShellEnvScript "$FN_URL" "$FN_DIR"


    # Funções :: interface
    FN_DIR="${TARGET_DIR}functions/interface/"
    FN_URL="${URL_MYSHELLENV}functions/interface/"
    TARGET_SCRIPTS=("alertUser.sh" "errorAlert.sh" "promptUser.sh" "setIMessage.sh" "waitUser.sh")
    downloadMyShellEnvScript "$FN_URL" "$FN_DIR"


    # Funções :: string
    FN_DIR="${TARGET_DIR}functions/string/"
    FN_URL="${URL_MYSHELLENV}functions/string/"
    TARGET_SCRIPTS=(
      "toLowerCase.sh" "toUpperCase.sh"
      "trim.sh" "trimD.sh" "trimDL.sh" "trimDR.sh" "trimL.sh" "trimR.sh"
    )
    downloadMyShellEnvScript "$FN_URL" "$FN_DIR"


    # Funções :: terminal
    FN_DIR="${TARGET_DIR}functions/terminal/"
    FN_URL="${URL_MYSHELLENV}functions/terminal/"
    TARGET_SCRIPTS=("setUTF8.sh" "showPromptOptions.sh" "showScreenColors.sh" "showTextColors.sh")
    downloadMyShellEnvScript "$FN_URL" "$FN_DIR"  fi


    # Funções :: thirdPart
    FN_DIR="${TARGET_DIR}functions/thirdPart/"
    FN_URL="${URL_MYSHELLENV}functions/thirdPart/"
    TARGET_SCRIPTS=("print256colours.sh")
    downloadMyShellEnvScript "$FN_URL" "$FN_DIR"  fi


    # prompts
    FN_DIR="${TARGET_DIR}prompts/"
    FN_URL="${URL_MYSHELLENV}prompts/"
    TARGET_SCRIPTS=("prompt.sh")
    downloadMyShellEnvScript "$FN_URL" "$FN_DIR"  fi
}
