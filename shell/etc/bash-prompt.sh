#!/bin/bash

# Definição de variáveis para uso em mensagens coloridas
NONE="\033[00m"

## Cor de Fonte
BLACK="\033[30m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
PURPLE="\033[35m"
CYAN="\033[36m"
WHITE="\033[37m"


## Atributo
BOLD="\033[01m"
UNDERLINE="\033[03m"
BLINK="\033[05m"


# Exemplo de uso
# echo -e "This text is ${RED}red${NONE} and ${GREEN}green${NONE} and ${BOLD}bold${NONE} and ${UNDERLINE}underlined${NONE}."





## - Padrões de prompt
# $ rianna@archlinux : _
PRINTSTYLE01="$ username@host : ${NONE}"
PSTYLE01="\$ \u@\h : "

# $ rianna@archlinux : _
PRINTSTYLE02A="${GREEN}$ username@host : ${NONE}"
PSTYLE02A="\[\e[40;01;32m\]\$ \u@\h : \[\e[40;00;37m\]"

# $ rianna@archlinux : _
PRINTSTYLE02B="${CYAN}$ ${GREEN}username@host ${CYAN}: ${NONE}"
PSTYLE02B="\[\e[40;01;36m\]\$ \[\e[40;00;32m\]\u@\h \[\e[40;01;36m\]: \[\e[40;00;37m\]"

# $ rianna@archlinux : _
PRINTSTYLE02C="${CYAN}$ ${GREEN}username${WHITE}@${GREEN}host ${CYAN}: ${NONE}"
PSTYLE02C="\[\e[40;01;36m\]\$ \[\e[40;00;32m\]\u\[\e[40;00;37m\]@\[\e[40;00;32m\]\h\[\e[40;01;36m\] : \[\e[40;00;37m\]"

# $ rianna@archlinux in ~/DirName/SubDir
# > _
PRINTSTYLE03A="${CYAN}$ ${GREEN}username${WHITE}@${GREEN}host ${BLUE}in ${CYAN}~/atual/directory/path \n> ${NONE}"
PSTYLE03A="\[\e[40;01;36m\]\$ \[\e[40;00;32m\]\u\[\e[40;00;37m\]@\[\e[40;00;32m\]\h\[\e[40;01;34m\] in \[\e[40;00;36m\]\w \n\[\e[40;01;34m\]\076 \[\e[40;00;37m\]"

# ┌── $ rianna@archlinux in ~/DirName/SubDir
# └──╼ _
PRINTSTYLE03B="${CYAN}\342\224\214\342\224\200\342\224\200 $ ${GREEN}username${WHITE}@${GREEN}host ${BLUE}in ${CYAN}~/atual/directory/path \n${CYAN}\342\224\224\342\224\200\342\224\200\342\225\274 ${NONE}"
PSTYLE03B="\[\e[40;00;36m\]\342\224\214\342\224\200\342\224\200 \[\e[40;01;34m\]\$ \[\e[40;00;32m\]\u\[\e[40;00;37m\]@\[\e[40;00;32m\]\h\[\e[40;01;34m\] in \[\e[40;00;36m\]\w \n\[\e[40;00;36m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\e[40;00;37m\]"

# ┌── $ rianna@archlinux in ~/DirName/SubDir
# └──> _
PRINTSTYLE03C="${CYAN}\342\224\214\342\224\200\342\224\200 $ ${GREEN}username${WHITE}@${GREEN}host ${BLUE}in ${CYAN}~/atual/directory/path \n${CYAN}\342\224\224\342\224\200\342\224\200\076 ${NONE}"
PSTYLE03C="\[\e[40;00;36m\]\342\224\214\342\224\200\342\224\200 \[\e[40;01;34m\]\$ \[\e[40;00;32m\]\u\[\e[40;00;37m\]@\[\e[40;00;32m\]\h\[\e[40;01;34m\] in \[\e[40;00;36m\]\w \n\[\e[40;00;36m\]\342\224\224\342\224\200\342\224\200\076 \[\e[40;00;37m\]"




showPromptOptions() {
  printf "\n\n\nAs seguintes opcoes de prompt estao disponiveis:"
  printf "\n\n"
  printf "> PSTYLE01 \n"
  printf "$PRINTSTYLE01"
  printf "\n\n"
  printf "> PSTYLE02A \n"
  printf "$PRINTSTYLE02A"
  printf "\n\n"
  printf "> PSTYLE02B \n"
  printf "$PRINTSTYLE02B"
  printf "\n\n"
  printf "> PSTYLE02C \n"
  printf "$PRINTSTYLE02C"
  printf "\n\n"
  printf "> PSTYLE03A \n"
  printf "$PRINTSTYLE03A"
  printf "\n\n"
  printf "> PSTYLE03B \n"
  printf "$PRINTSTYLE03B"
  printf "\n\n"
  printf "> PSTYLE03C \n"
  printf "$PRINTSTYLE03C"
  printf "\n__________________________________________________"
  printf "\n\n\n"
}
