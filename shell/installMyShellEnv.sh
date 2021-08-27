#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set -eu





#
# Variáveis para uso com as funções básicas de sessão
ALERT_MSG=()
ALERT_INDENT="    "

PROMPT_OPTIONS="sim(s) | nao(n)"
PROMPT_MSG=()
PROMPT_INDENT="    "
PROMPT_RESULT=""

URL_ETC="https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/"
URL_MYSHELLENV="https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/skel/myShellEnv/"





#
# Definição de cores para uso em strings
## Cores
### 'D' indica 'Dark'
### 'L' indica 'Light'

NONE="\e[00m"

BLACK="\e[00;30m"
DGREY="\e[01;30m"
WHITE="\e[00;37m"
SILVER="\e[01;37m"

RED="\e[00;31m"
LRED="\e[01;31m"

GREEN="\e[00;32m"
LGREEN="\e[01;32m"

BROWN="\e[00;33m"
YELLOW="\e[01;33m"

BLUE="\e[00;34m"
LBLUE="\e[01;34m"

PURPLE="\e[00;35m"
LPURPLE="\e[01;35m"

CYAN="\e[00;36m"
LCYAN="\e[01;36m"



## Atributo de fonte
BOLD="\e[01m"
UNDERLINE="\e[03m"
BLINK="\e[05m"





#
# Converte o argumento passado para minúsculas.
#
#   param string $1 string que será convertida
#   example
#     result=$(toLowerCase "TEXT")
#
toLowerCase() {
  echo "${1,,}"
}
#
# Converte o argumento passado para maiúsculas.
#
#   param string $1 string que será convertida.
#   example
#     result=$(toUpperCase "TEXT")
#
toUpperCase() {
  echo "${1^^}"
}
#
# Mostra uma mensagem de alerta para o usuário.
# A mensagem mostrada deve ser preparada no array ${ALERT_MSG}
# onde, cada item do array será definido em uma linha do terminal
#
#   example
#     ALERT_MSG=()
#     ALERT_MSG[0]=$(printf "${SILVER}Sucesso!${NONE}")
#     ALERT_MSG[1]=$(printf "Todos os scripts foram atualizados")
#
#     alertUser
#
alertUser() {
  if [ ${#ALERT_MSG[@]} = 0 ]; then
    echo -e "\e[01;37m${ALERT_INDENT}ERROR (fn alertUser): empty array \e[01;ALERT_MSG\e[00m"
    echo -e ""
  else
    for msg in "${ALERT_MSG[@]}"; do
      echo "${ALERT_INDENT}$msg"
    done

    ALERT_MSG=()
  fi
}
#
# Mostra uma mensagem para o usuário e questiona sobre Sim ou Não
# A mensagem mostrada deve ser preparada no array ${PROMPT_MSG}
# onde, cada item do array será definido em uma linha do terminal.
#
# O resultado selecionado pelo usuário ficará definido na variável ${PROMPT_RESULT}
# armazenando os valores:
#   0 : nao(n)
#   1 : sim(s)
#
#   example
#     PROMPT_MSG=()
#     PROMPT_MSG[0]=$(printf "${SILVER}ATENÇÃO!${NONE}")
#     PROMPT_MSG[1]=$(printf "Deseja prosseguir?")
#
#     promptUser
#     if [ "$PROMPT_RESULT" == "1" ]; then
#       echo "Escolhido Sim"
#     else
#       echo "Escolhido Não"
#     fi
#
promptUser() {
  PROMPT_RESULT=""


  if [ ${#PROMPT_MSG[@]} = 0 ]; then
    echo -e "\e[01;37m${PROMPT_INDENT}ERROR (fn promptUser): empty array \e[01;32mPROMPT_MSG\e[00m"
    echo -e ""
  else

    while [ "$PROMPT_RESULT" != "sim" ] && [ "$PROMPT_RESULT" != "s" ] && [ "$PROMPT_RESULT" != "nao" ] && [ "$PROMPT_RESULT" != "n" ]; do
      if [ "$PROMPT_RESULT" != "" ]; then
        echo "   Esperado apenas [ ${PROMPT_OPTIONS} ]: \"$PROMPT_RESULT\""
      fi

      echo ""
      for msg in "${PROMPT_MSG[@]}"; do
        echo "${PROMPT_INDENT}$msg"
      done

      read -p "${PROMPT_INDENT}[ ${PROMPT_OPTIONS} ] : " PROMPT_RESULT
      PROMPT_RESULT=$(toLowerCase "$PROMPT_RESULT")
    done


    if [ "$PROMPT_RESULT" == "nao" ] || [ "$PROMPT_RESULT" == "n" ]; then
      PROMPT_RESULT=0
    fi

    if [ "$PROMPT_RESULT" == "sim" ] || [ "$PROMPT_RESULT" == "s" ]; then
      PROMPT_RESULT=1
    fi

    PROMPT_MSG=()
  fi
}




clear
ALERT_MSG=()
ALERT_MSG[0]=""
ALERT_MSG[1]=$(printf "${SILVER}myShellEnv${NONE}")
ALERT_MSG[2]=$(printf "Iniciando o processo de instalação.")
alertUser


INSTALL_IN_SKEL=0
INSTALL_LOGIN_MESSAGE=0
INSTALL_USER_IS_ROOT=0

if [ "$EUID" == 0 ]; then
  INSTALL_USER_IS_ROOT=1

  ALERT_MSG=()
  ALERT_MSG[0]=""
  ALERT_MSG[1]=$(printf "Você foi identificado como um usuário com privilégios ${LBLUE}root${NONE}")
  ALERT_MSG[2]=$(printf "Isto significa que você tem permissão para instalar o ${SILVER}myShellEnv${NONE}")
  ALERT_MSG[3]=$(printf "para ${SILVER}todo novo usuário${NONE} criado nesta máquina.")
  alertUser

  PROMPT_MSG=()
  PROMPT_MSG[0]=$(printf "Você deseja fazer uma instalação global (${LBLUE}skel${NONE})?")
  PROMPT_MSG[1]=$(printf "[ ${DGREY}Usuários existentes não serão alterados!${NONE} ]")
  PROMPT_MSG[2]=""

  promptUser
  INSTALL_IN_SKEL=$PROMPT_RESULT
  PROMPT_RESULT=""


  PROMPT_MSG=()
  PROMPT_MSG[0]=""
  PROMPT_MSG[1]=$(printf "Você deseja instalar a mensagem de login?")
  PROMPT_MSG[2]=$(printf "[ ${DGREY}Ela será vista por todos os usuários!${NONE} ]")
  PROMPT_MSG[3]=""

  promptUser
  INSTALL_LOGIN_MESSAGE=$PROMPT_RESULT
  PROMPT_RESULT=""
fi





#
# Sendo para instalar no skel...
if [ "$INSTALL_IN_SKEL" == "1" ]; then
  mkdir -p /etc/skel/myShellEnv

  curl -s -o /etc/skel/myShellEnv/aliases.sh "${URL_MYSHELLENV}aliases.sh"
  curl -s -o /etc/skel/myShellEnv/functions.sh "${URL_MYSHELLENV}functions.sh"
  curl -s -o /etc/skel/myShellEnv/prompt.sh "${URL_MYSHELLENV}prompt.sh"
  curl -s -o /etc/skel/myShellEnv/shellEnvStart.sh "${URL_MYSHELLENV}shellEnvStart.sh"
  curl -s -o /etc/skel/myShellEnv/variables.sh "${URL_MYSHELLENV}variables.sh"



  mkdir -p /etc/skel/myShellEnv/thirdPartFunctions

  curl -s -o /etc/skel/myShellEnv/thirdPartFunctions/print256colours.sh "${URL_MYSHELLENV}thirdPartFunctions/print256colours.sh"


  ALERT_MSG=()
  ALERT_MSG[0]=""
  ALERT_MSG[1]=$(printf "${SILVER}Instalação no skel concluída${NONE}")
  alertUser
fi





#
# Sendo para instalar a mensagem de login
if [ "$INSTALL_LOGIN_MESSAGE" == "1" ]; then
  curl -s -o /etc/issue "${URL_ETC}issue"

  ALERT_MSG=()
  ALERT_MSG[0]=""
  ALERT_MSG[1]=$(printf "${SILVER}Instalação da mensagem de login concluída${NONE}")
  alertUser
fi





#
# Verifica se é para efetuar a instalação do 'myShellEnv' para o usuário atual.
PROMPT_MSG=()
PROMPT_MSG[0]=$(printf "Prosseguir instalação para o seu próprio usuário?")

promptUser
if [ "$PROMPT_RESULT" == "1" ]; then
  mkdir -p ~/myShellEnv

  curl -s -o ~/myShellEnv/aliases.sh "${URL_MYSHELLENV}aliases.sh"
  curl -s -o ~/myShellEnv/functions.sh "${URL_MYSHELLENV}functions.sh"
  curl -s -o ~/myShellEnv/prompt.sh "${URL_MYSHELLENV}prompt.sh"
  curl -s -o ~/myShellEnv/shellEnvStart.sh "${URL_MYSHELLENV}shellEnvStart.sh"
  curl -s -o ~/myShellEnv/variables.sh "${URL_MYSHELLENV}variables.sh"



  mkdir -p ~/myShellEnv/thirdPartFunctions

  curl -s -o ~/myShellEnv/thirdPartFunctions/print256colours.sh "${URL_MYSHELLENV}thirdPartFunctions/print256colours.sh"


  ALERT_MSG=()
  ALERT_MSG[0]=""
  ALERT_MSG[1]=$(printf "${SILVER}Instalação para o seu usuário concluída${NONE}")
  alertUser
fi
PROMPT_RESULT=""




ALERT_MSG=()
ALERT_MSG[0]=$(printf "${SILVER}Processo de instalação encerrado!${NONE}")
alertUser

rm installMyShellEnv.sh | true
