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
#   @param string $1
#   String que será convertida
#
#   @example
#     result=$(toLowerCase "TEXT")
#
toLowerCase() {
  echo "$1" | awk '{print tolower($0)}'
}
#
# Converte o argumento passado para maiúsculas.
#
#   @param string $1
#   String que será convertida.
#
#   @example
#     result=$(toUpperCase "TEXT")
#
toUpperCase() {
  echo "$1" | awk '{print toupper($0)}'
}
#
# Elimina qualquer espaço em branco no início da string indicada.
#
#   @param string $1
#   String que será alterada.
#
#   @example
#     result=$(trimL "   texto aqui   ")
#     echo $result # "texto aqui   "
#
trimL() {
  echo "$1" | sed 's/^\s*//g'
}
#
# Elimina qualquer espaço em branco no final da string indicada.
#
#   @param string $1
#   String que será alterada.
#
#   @example
#     result=$(trimR "   texto aqui   ")
#     echo $result # "   texto aqui"
#
trimR() {
  echo "$1" | sed 's/\s*$//g'
}
#
# Elimina qualquer espaços em branco no início ou no final de uma string.
#
#   @param string $1
#   String que será alterada.
#
#   @example
#     result=$(trim "   texto aqui   ")
#     echo $result # "texto aqui"
#
trim() {
  echo "$1" | trimL | trim R
}
#
# Elimina qualquer espaço em branco existente imediatamente
# ANTES do delimitador indicado.
#
#   @param string $1
#   Delimitador.
#
#   @param string $1
#   String que será alterada.
#
#   @example
#     result=$(trimDelimiterL ",", "Keep calm   ,   and...")
#     echo $result # "Keep calm,   and..."
#
trimDelimiterL() {
  echo "$2" | sed "'s/\s*$1/$1/g'"
}
#
# Elimina qualquer espaço em branco existente imediatamente
# APÓS do delimitador indicado.
#
#   @param string $1
#   Delimitador.
#
#   @param string $1
#   String que será alterada.
#
#   @example
#     result=$(trimDelimiterL ",", "Keep calm   ,   and...")
#     echo $result # "Keep calm   ,and..."
#
trimDelimiterL() {
  echo "$2" | sed "'s/$1\s*/$1/g'"
}
#
# Elimina qualquer espaço em branco existente imediatamente
# ANTES e APÓS o delimitador indicado.
#
#   @param string $1
#   Delimitador.
#
#   @param string $1
#   String que será alterada.
#
#   @example
#     result=$(trimDelimiter ":", "Keep  calm   :   and   ... :   think")
#     echo $result # "Keep  calm:and   ...:think"
#
trimDelimiter() {
  echo "$2" | sed "'s/\s*$1/$1/g'" | sed "'s/$1\s*/$1/g'"
}
