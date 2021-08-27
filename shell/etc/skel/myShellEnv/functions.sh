#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





#
# Mostra as cores disponíveis no shell para estilização das mensagens.
#
showMyShellEnvColors() {
  printf "\n\n"
  printf "As seguintes opções de cores estão disponíveis:"
  printf "\n\n"

  printf "Preto:          ${BLACK}My Shell Env${NONE}  | Marrom:         ${BROWN}My Shell Env${NONE} \n"
  printf "Cinza escuro:   ${DGREY}My Shell Env${NONE}  | Amarelo:        ${YELLOW}My Shell Env${NONE} \n"
  printf "Branco:         ${WHITE}My Shell Env${NONE}  | Azul:           ${BLUE}My Shell Env${NONE} \n"
  printf "Prata:          ${SILVER}My Shell Env${NONE}  | Azul claro:     ${LBLUE}My Shell Env${NONE} \n"
  printf "Vermelho:       ${RED}My Shell Env${NONE}  | Púrpura:        ${PURPLE}My Shell Env${NONE} \n"
  printf "Vermelho claro: ${LRED}My Shell Env${NONE}  | Púrpura claro:  ${LPURPLE}My Shell Env${NONE} \n"
  printf "Verde:          ${GREEN}My Shell Env${NONE}  | Ciano:          ${CYAN}My Shell Env${NONE} \n"
  printf "Verde claro:    ${LGREEN}My Shell Env${NONE}  | Ciano claro:    ${LCYAN}My Shell Env${NONE} \n"
  printf "\n\n"
}
#
# Mostra todas as opções de prompt que estão disponíveis para seleção.
#
showPromptOptions() {
  # alterar isto para aceitar um array e mostrar casos 'on demmand' para o usuário
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
  printf "\n\n"
  printf "> PSTYLE03D \n"
  printf "$PRINTSTYLE03D"
  printf "\n__________________________________________________"
  printf "\n\n\n"
}




















#
# Efetua o registro de funções de usuário aos arrays de controle.
#
# param $1 nome da função
# param $2 descrição da função
#
# return void
registerUserFunction() {
  if [ "$#" != "2" ]; then
    echo "Error: expected 2 arguments"
  else
    length=${#FUNCTION_NAMES[@]}
    FUNCTION_NAMES[length]=$1
    FUNCTION_DESCRIPTIONS[length]=$2
  fi
}



#
# Lista todas as funções de usuário registradas no momento
#
# return void
listUserFunctions() {
  length=${#FUNCTION_NAMES[@]}

  for ((i=0;i<length;i++)); do
    fName=${FUNCTION_NAMES[i]}
    fDesc=${FUNCTION_DESCRIPTIONS[i]}
    num=i+1

    if num < 10 ; then
      num="0${num}"
    fi

    echo -e "${num} :: ${fName}"
    echo -e "    ${fDesc}"
  done
}







# Use para ativar/desativar o UTF8 do seu shell
# Para ativar use: ``terminalUTF8 on``
# Para ativar use: ``terminalUTF8 off``
terminalUTF8() {
  if test ".$1" = ".off" ; then
    printf '\033%%@'
    echo -e "UTF-8 off"
  else
    printf '\033%%G'
    echo -e "UTF-8 on"
    echo -e "\u2705"
  fi
}



thirdPart_print256colours() {
  source ~/myShellEnv/thirdPartFunctions/print256colours.sh || true
}
