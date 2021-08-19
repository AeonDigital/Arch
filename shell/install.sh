#!/bin/bash
#
# Torne este arquivo executável executando o comando abaixo
# chmod u+x install.sh
#
# Execute assim
# ./install.sh
#






loadkeys br-abnt2

# Configuração de mensagens
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



# Variáveis
mother_board=""
next=""





# Funções
## Converte o argumento passado para minusculas
toLowerCase() {
  echo "${1,,}"
}

## Converte o argumento passado para maiusculas
toUpperCase() {
  echo "${1^^}"
}

## Lê o tipo de placa mãe
readMotherBoard() {
  while [ "$mother_board" != "BIOS" ] && [ "$mother_board" != "UEFI" ]; do
    if [ "$mother_board" != "" ]; then
      echo "   O tipo de placa mãe informado é inválido: \"$mother_board\""
    fi

    echo ""
    echo "$1"
    read -p "   [ BIOS | UEFI ] : " mother_board
    mother_board=$(toUpperCase "$mother_board")
  done
}

## Identifica se é para seguir adiante
readNext() {
  next=""
  
  while [ "$next" != "SIM" ] && [ "$next" != "S" ] && [ "$next" != "NAO" ] && [ "$next" != "N" ]; do
    if [ "$next" != "" ]; then
      echo "   Esperado apenas S/N: \"$next\""
    fi

    echo ""
    echo "$1"
    read -p "   [ SIM/S | NAO/N ] : " next
    next=$(toUpperCase "$next")
  done

  if [ "$next" == "SIM" ] || [ "$next" == "S" ]; then
    next="SIM"
  fi

  if [ "$next" == "NAO" ] || [ "$next" == "N" ]; then
    next="NAO"
  fi
}





echo -e ""
clear
echo -e ""
echo -e "- Iniciando a instalação do ${CYAN}Arch Linux${NONE}."
echo -e ""
echo -e ""
echo -e "- Download dos arquivos de script"
echo -e ""
curl -O https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/install-01.sh

echo -e ""
echo -e ""

curl -O https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/install-02.sh

echo -e ""
echo -e ""

curl -O https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/install-03.sh

chmod u+x install-01.sh
chmod u+x install-02.sh
chmod u+x install-03.sh

echo -e ""
echo -e ""

echo -e "${CYAN}Scripts de instalação foram baixados.${NONE}"
echo -e "- Use o comando abaixo para prosseguir."
echo -e "> ${CYAN}install-01.sh${NONE}"

echo -e ""
echo -e ""
