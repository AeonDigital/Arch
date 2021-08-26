#!/bin/bash

# Use este script para adicionar funções que deseja disponibilizar para todas as 
# seções dos usuários desta máquina.



arrFunctionNames=()
arrFunctionDescriptions=()
AEONGIT="https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/"



#
# Atualiza os arquivos que compõe o bash personalizado
#
updateBash() {
  msg=$(printf "
  ${SILVER}ATENÇÃO!${NONE}
    Esta ação irá atualizar os scripts de sessão.
    Qualquer personalização dos mesmos feitos até o momento serão perdidos
    
    Tem certeza que deseja prosseguir?")


  promptUser "${msg}"
  msgReturn=""

  if [ "$PROMPT_RESULT" == 1 ]; then
    curl -O "${AEONGIT}update-bash.sh"
    chmod u+x update-bash.sh
    ./update-bash.sh
    rm update-bash.sh

    msgReturn=$(echo -e "${SILVER}Os scripts de sessão foram atualizados${NONE}\n")
    msgReturn=$(echo -e "${msgReturn}Use o comando ${GREEN}updateBashForMyUser${NONE} para atualizar sua conta de usuário.")
  else
    msgReturn=$(echo -e "${SILVER}Nenhuma ação foi feita${NONE}")
  fi

  echo ""
  echo "${msgReturn}"
  echo ""

  PROMPT_RESULT=""
}



#
# Atualiza os arquivos '.bashrc' e '.bash_profile' do usuário que chamou esta função.
#
updateBashForMyUser() {
  msg=$(printf "
  ${SILVER}ATENÇÃO!${NONE}
    Esta ação irá substituir seus arquivos pessoais:
    - ${LCYAN}~/.bash_profile${NONE}
    - ${LCYAN}~/.bashrc${NONE}
    
    Tem certeza que deseja prosseguir?")


  promptUser "${msg}"
  msgReturn=""

  if [ "$PROMPT_RESULT" == 1 ]; then
    cp -a /etc/skel/.bash_profile ~/.bash_profile
    cp -a /etc/skel/.bashrc ~/.bashrc
    source ~/.bash_profile

    msgReturn=$(echo -e "${SILVER}Seu ambiente bash está atualizado${NONE}")
  else
    msgReturn=$(echo -e "${SILVER}Nenhuma ação foi feita${NONE}")
  fi

  echo ""
  echo "${msgReturn}"
  echo ""

  PROMPT_RESULT=""
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
    length=${#arrFunctionNames[@]}
    arrFunctionNames[length]=$1
    arrFunctionDescriptions[length]=$2
  fi
}



#
# Lista todas as funções de usuário registradas no momento
#
# return void
listUserFunctions() {
  length=${#arrFunctionNames[@]}

  for ((i=0;i<length;i++)); do 
    fName=${arrFunctionNames[i]}
    fDesc=${arrFunctionDescriptions[i]}
    num=i+1

    if num < 10 ; then
      num="0${num}"
    fi

    echo -e "${num} :: ${fName}"
    echo -e "    ${fDesc}"
  done
}





# reexecuta o script de início de sessão
sessionStart() {
  source ~/.bash_profile
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






# Printa as paletas de cores
printPallete() {
  print_run 0 16 # The first 16 colours are spread over the whole spectrum
  printf "\n"
  print_blocks 16 231 6 6 3 # 6x6x6 colour cube between 16 and 231 inclusive
  print_blocks 232 255 12 2 1 # Not 50, but 24 Shades of Grey
}





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
  printf "\n\n"
  printf "> PSTYLE03D \n"
  printf "$PRINTSTYLE03D"
  printf "\n__________________________________________________"
  printf "\n\n\n"
}
