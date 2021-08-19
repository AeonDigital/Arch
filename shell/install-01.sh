#!/bin/bash
#
# Torne este arquivo executável executando o comando abaixo
# chmod u+x install-01.sh
#
# Execute assim
# ./install-01.sh
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
echo -e "- Preparando o disco para instalação do ${CYAN}Arch Linux${NONE}."
echo -e ""
echo -e ""
readMotherBoard "- Qual o tipo da placa mãe em que esta instalação está sendo feita?"
readNext "-- Deseja prosseguir?"


if [ "$next" != "SIM" ]; then
  echo -e ""
  echo "-- Instalação encerrada!"
  echo -e ""
  echo -e ""
else
  echo -e ""
  echo -e "   - Preparando a unidade de armazenamento persistente"
  if [ "$mother_board" == "UEFI" ]; then
    echo -e "     Preparando para receber sistema usando placa mãe do tipo ${CYAN}UEFI - GPT${NONE}."
    echo -e "g\nn\n\n\n+512M\nt\n1\nn\n\n\n+512M\nt\n\n19\nn\n\n\n\nw" | fdisk /dev/sda
  else
    echo -e "     Preparando para receber sistema usando placa mãe do tipo ${CYAN}BIOS - MBR${NONE}."
    echo -e "o\nn\n\n\n+512M\nt\n4\nn\n\n\n+512M\nt\n\n19\nn\n\n\n\nw" | fdisk /dev/sda
  fi


  echo -e "   - Preparo da unidade de armazenamento persistente concluído:"
  fdisk -l /dev/sda

  readNext "-- Deseja prosseguir?"
  if [ "$next" != "SIM" ]; then
    echo -e ""
    echo "-- Instalação encerrada!"
    echo -e ""
    echo -e ""
  else
    echo -e ""
    echo -e "- Formatando as partições criadas"
    mkfs.fat -F32 /dev/sda1
    mkswap /dev/sda2
    mkfs.ext4 /dev/sda3


    echo -e ""
    echo -e ""

    echo -e "- Montando as partições e preparando o filesystem"
    mount /dev/sda3 /mnt
    mkdir /mnt/boot 
    mkdir /mnt/home
    mount /dev/sda1 /mnt/boot
    swapon /dev/sda2


    echo -e ""
    echo -e ""

    echo -e "${CYAN}Processo de configuração do disco finalizado.${NONE}"
    echo -e "- Use o comando abaixo para prosseguir."
    echo -e "> ${CYAN}install-02.sh${NONE}"

    echo -e ""
    echo -e ""
  fi
fi
