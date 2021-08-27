#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set -eu





#
# Repositório dos scripts
URL_ETC="https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/"
URL_MYSHELLENV="https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/skel/myShellEnv/"
URL_UPDATE="https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/"



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



# Exemplo de uso
# printf "This text is ${RED}red${NONE} and ${GREEN}green${NONE} and
#    ${BOLD}bold${NONE} and ${UNDERLINE}underlined${NONE}."




#
# Variáveis para uso com as funções de interface
ALERT_MSG=()
ALERT_INDENT="    "
ALERT_WAIT_PROMPT="Precione qualquer tecla para prosseguir."

PROMPT_OPTIONS="sim(s) | nao(n)"
PROMPT_MSG=()
PROMPT_INDENT="    "
PROMPT_RESULT=""

FUNCTION_NAMES=()
FUNCTION_DESCRIPTIONS=()

INTERFACE_MSG=()





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
#
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
  if [ ${#ALERT_MSG[@]} == 0 ] && [ ${#INTERFACE_MSG[@]} == 0 ]; then
    printf "${SILVER}${ALERT_INDENT}ERROR (fn alertUser): empty array ${LGREEN}ALERT_MSG${NONE} \n\n"
  else
    if [ ${#ALERT_MSG[@]} == 0 ]; then
      ALERT_MSG=("${INTERFACE_MSG[@]}")
    fi

    for msg in "${ALERT_MSG[@]}"; do
      printf "${ALERT_INDENT}$msg \n"
    done

    ALERT_MSG=()
    INTERFACE_MSG=()
  fi
}
#
# Mostra uma mensagem de alerta para o usuário e aguarda ele digitar qualquer tecla.
#
# A mensagem mostrada deve ser preparada no array ${ALERT_MSG}
# onde, cada item do array será definido em uma linha do terminal
#
#   example
#     ALERT_MSG=()
#     ALERT_MSG[0]=$(printf "${SILVER}Sucesso!${NONE}")
#     ALERT_MSG[1]=$(printf "Todos os scripts foram atualizados")
#
#     waitUser
#
waitUser() {
  if [ ${#ALERT_MSG[@]} == 0 ] && [ ${#INTERFACE_MSG[@]} == 0 ]; then
    printf "${SILVER}${ALERT_INDENT}ERROR (fn waitUser): empty array ${LGREEN}ALERT_MSG${NONE} \n\n"
  else
    if [ ${#ALERT_MSG[@]} == 0 ]; then
      ALERT_MSG=("${INTERFACE_MSG[@]}")
    fi

    for msg in "${ALERT_MSG[@]}"; do
      printf "${ALERT_INDENT}$msg \n"
    done

    cr="echo $'\n.'"
    cr=${cr%.}
    read -n 1 -s -r -p "${ALERT_INDENT}[ ${ALERT_WAIT_PROMPT} ] $cr"

    ALERT_MSG=()
    INTERFACE_MSG=()
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
#       printf "Escolhido Sim"
#     else
#       printf "Escolhido Não"
#     fi
#
promptUser() {
  PROMPT_RESULT=""

  if [ ${#PROMPT_MSG[@]} == 0 ] && [ ${#INTERFACE_MSG[@]} == 0 ]; then
    printf "${SILVER}${ALERT_INDENT}ERROR (fn promptUser): empty array ${LGREEN}PROMPT_MSG${NONE} \n\n"
  else
    if [ ${#PROMPT_MSG[@]} == 0 ]; then
      PROMPT_MSG=("${INTERFACE_MSG[@]}")
    fi

    while [ "$PROMPT_RESULT" != "sim" ] && [ "$PROMPT_RESULT" != "s" ] && [ "$PROMPT_RESULT" != "nao" ] && [ "$PROMPT_RESULT" != "n" ]; do
      if [ "$PROMPT_RESULT" != "" ]; then
        printf "${PROMPT_INDENT}Esperado apenas [ ${PROMPT_OPTIONS} ]: \"$PROMPT_RESULT\" \n"
      fi

      for msg in "${PROMPT_MSG[@]}"; do
        printf "${PROMPT_INDENT}$msg \n"
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
    INTERFACE_MSG=()
  fi
}





#
# Adiciona uma nova linha de informação no array de mensagem
# de interface ${INTERFACE_MSG}
#
#   param string $1 nova linha da mensagem
#   param bool $2 use '1' quando quiser que o array seja reiniciado.
#                 Qualquer outro valor não causará efeitos
#   example
#     setIMessage "Atenção" 1
#     setIMessage "Todos os arquivos serão excluídos."
#
setIMessage() {
  if [ $# != 1 ] && [ $# != 2 ]; then
    printf "Error: expected 1 or 2 arguments \n"
  else
    if [ $# == 2 ] && [ $2 == 1 ]; then
      INTERFACE_MSG=()
    fi

    l=${#INTERFACE_MSG[@]}
    INTERFACE_MSG[l]=$1
  fi
}





clear
setIMessage "" 1
setIMessage "${SILVER}myShellEnv${NONE}"
setIMessage "Iniciando o processo de instalação."
alertUser


INSTALL_IN_SKEL=0
INSTALL_LOGIN_MESSAGE=0
INSTALL_IN_MY_USER=0


# sendo um root...
if [ "$EUID" == 0 ]; then
  setIMessage "" 1
  setIMessage "Você foi identificado como um usuário com privilégios ${LBLUE}root${NONE}"
  setIMessage "Isto significa que você tem permissão para instalar o ${SILVER}myShellEnv${NONE}"
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
  mkdir -p /etc/skel/myShellEnv

  curl -s -o /etc/skel/myShellEnv/aliases.sh "${URL_MYSHELLENV}aliases.sh"
  curl -s -o /etc/skel/myShellEnv/interface.sh "${URL_MYSHELLENV}interface.sh"
  curl -s -o /etc/skel/myShellEnv/functions.sh "${URL_MYSHELLENV}functions.sh"
  curl -s -o /etc/skel/myShellEnv/prompt.sh "${URL_MYSHELLENV}prompt.sh"
  curl -s -o /etc/skel/myShellEnv/start.sh "${URL_MYSHELLENV}start.sh"
  curl -s -o /etc/skel/myShellEnv/variables.sh "${URL_MYSHELLENV}variables.sh"



  mkdir -p /etc/skel/myShellEnv/thirdPartFunctions

  curl -s -o /etc/skel/myShellEnv/thirdPartFunctions/print256colours.sh "${URL_MYSHELLENV}thirdPartFunctions/print256colours.sh"


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
# Sendo para instalar no próprio usuário...
if [ "$INSTALL_IN_MY_USER" == "1" ]; then
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
  setIMessage "${SILVER}Instalação para o seu usuário concluída${NONE}"
  alertUser
fi





#
# Encerra o script
setIMessage "" 1
setIMessage "${SILVER}Processo de instalação encerrado!${NONE}"
if [ "$INSTALL_IN_MY_USER" == "1" ]; then
  setIMessage "As atualizações serão carregadas automaticamente."
fi
setIMessage ""


rm installMyShellEnv.sh || true
waitUser


if [ "$INSTALL_IN_MY_USER" == "1" ]; then
  source ~/myShellEnv/start.sh || true
fi
