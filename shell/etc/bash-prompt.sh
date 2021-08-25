#!/bin/bash



# - Padrões de prompt

## $ rianna@archlinux : _
PRINTSTYLE01="${NONE}$ username@host : "
PSTYLE01="\[\e[40;00;37m\]\$ \u@\h : "


# $ rianna@archlinux : _
PRINTSTYLE02A="${NONE}${GREEN}$ username@host : ${NONE}"
PSTYLE02A="\[\e[40;00;32m\]\$ \u@\h : \[\e[40;00;37m\]"


# $ rianna@archlinux : _
PRINTSTYLE02B="${NONE}${CYAN}$ ${GREEN}username@host ${CYAN}: ${NONE}"
PSTYLE02B="\[\e[40;00;36m\]\$ \[\e[40;00;32m\]\u@\h \[\e[40;00;36m\]: \[\e[40;00;37m\]"


# $ rianna@archlinux : _
PRINTSTYLE02C="${CYAN}$ ${GREEN}username${WHITE}@${GREEN}host ${CYAN}: ${NONE}"
PSTYLE02C="\[\e[40;01;36m\]\$ \[\e[40;00;32m\]\u\[\e[40;00;37m\]@\[\e[40;00;32m\]\h\[\e[40;01;36m\] : \[\e[40;00;37m\]"


# $ rianna@archlinux in ~/DirName/SubDir
# > _
PRINTSTYLE03A="${CYAN}$ ${GREEN}username${WHITE}@${GREEN}host ${BLUE}in ${CYAN}~/atual/directory/path \n> ${NONE}"
PSTYLE03A="\[\e[40;01;36m\]\$ \[\e[40;00;32m\]\u\[\e[40;00;37m\]@\[\e[40;00;32m\]\h\[\e[40;01;34m\] in \[\e[40;00;36m\]\w \n\[\e[40;01;34m\]\076 \[\e[40;00;37m\]"


# ┌── $ rianna@archlinux in ~/DirName/SubDir
# └─╼ _
PRINTSTYLE03B="${CYAN}\342\224\214\342\224\200\342\224\200 $ ${GREEN}username${WHITE}@${GREEN}host ${BLUE}in ${CYAN}~/atual/directory/path \n${CYAN}\342\224\224\342\224\200\342\225\274 ${NONE}"
PSTYLE03B="\[\e[40;00;36m\]\342\224\214\342\224\200\342\224\200 \[\e[40;01;34m\]\$ \[\e[40;00;32m\]\u\[\e[40;00;37m\]@\[\e[40;00;32m\]\h\[\e[40;01;34m\] in \[\e[40;00;36m\]\w \n\[\e[40;00;36m\]\342\224\224\342\225\274 \[\e[40;00;37m\]"


# ┌── $ rianna@archlinux in ~/DirName/SubDir
# └─> _
PRINTSTYLE03C="${CYAN}\342\224\214\342\224\200\342\224\200 $ ${GREEN}username${WHITE}@${GREEN}host ${BLUE}in ${CYAN}~/atual/directory/path \n${CYAN}\342\224\224\342\224\200\076 ${NONE}"
PSTYLE03C="\[\e[40;00;36m\]\342\224\214\342\224\200\342\224\200 \[\e[40;01;34m\]\$ \[\e[40;00;32m\]\u\[\e[40;00;37m\]@\[\e[40;00;32m\]\h\[\e[40;01;34m\] in \[\e[40;00;36m\]\w \n\[\e[40;00;36m\]\342\224\224\342\224\200\076 \[\e[40;00;37m\]"




showColorOptions() {
  printf "\n\n"
  printf "As seguintes opções de cores estão disponíveis:"
  printf "\n\n"

  printf "Preto:          ${BLACK}Arch Linux${NONE}  | Marrom:         ${BROWN}Arch Linux${NONE} \n"
  printf "Cinza escuro:   ${DGREY}Arch Linux${NONE}  | Amarelo:        ${YELLOW}Arch Linux${NONE} \n"
  printf "Branco:         ${WHITE}Arch Linux${NONE}  | Azul:           ${BLUE}Arch Linux${NONE} \n"
  printf "Prata:          ${SILVER}Arch Linux${NONE}  | Azul claro:     ${LBLUE}Arch Linux${NONE} \n"
  printf "Vermelho:       ${RED}Arch Linux${NONE}  | Púrpura:        ${PURPLE}Arch Linux${NONE} \n"
  printf "Vermelho claro: ${LRED}Arch Linux${NONE}  | Púrpura claro:  ${LPURPLE}Arch Linux${NONE} \n"
  printf "Verde:          ${GREEN}Arch Linux${NONE}  | Ciano:          ${CYAN}Arch Linux${NONE} \n"
  printf "Verde claro:    ${LGREEN}Arch Linux${NONE}  | Ciano claro:    ${LCYAN}Arch Linux${NONE} \n"
  printf "\n\n"
}



showPromptOptions() {
  printf "\n\n\nAs seguintes opções de prompt estão disponíveis:"
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
