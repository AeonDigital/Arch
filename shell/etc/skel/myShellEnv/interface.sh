#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





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
    read -n 1 -s -r -p "${ALERT_INDENT}[ ${ALERT_WAIT_PROMPT} ] $'\n'"

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





#
# Atualiza os arquivos que compõe o 'myShellEnv'.
#
updateMyShellEnv() {
  curl -O "${URL_UPDATE}updateMyShellEnv.sh"
  chmod u+x updateMyShellEnv.sh
  ./updateMyShellEnv.sh
}
#
# Efetua a instalação completa do 'myShellEnv'.
#
reinstallMyShellEnv() {
  curl -O "${URL_UPDATE}installMyShellEnv.sh"
  chmod u+x installMyShellEnv.sh
  ./installMyShellEnv.sh
}
