#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





#
# Repositório dos scripts
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



# Exemplo de uso
# echo -e "This text is ${RED}red${NONE} and ${GREEN}green${NONE} and
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
  if [ ${#ALERT_MSG[@]} = 0 ]; then
    echo -e "\e[01;37m${ALERT_INDENT}ERROR (fn alertUser): empty array \e[01;ALERT_MSG\e[00m"
    echo -e ""
  else
    for msg in "${ALERT_MSG[@]}"; do
      echo "${ALERT_INDENT}$msg"
    done
    read -n 1 -s -r -p "${ALERT_INDENT}[ ${ALERT_WAIT_PROMPT} ]"

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





#
# Atualiza os arquivos que compõe o 'myShellEnv'.
#
updateMyShellEnv() {
  curl -O "${URL_MYSHELLENV}updateMyShellEnv.sh"
  chmod u+x updateMyShellEnv.sh
  ./updateMyShellEnv.sh
}
