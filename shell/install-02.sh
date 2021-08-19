#!/bin/bash
#
# Torne este arquivo executável executando o comando abaixo
# chmod u+x install-02.sh
#
# Execute assim
# ./install-02.sh
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
echo -e "- Iniciando a instalação dos pacotes básicos para o ${CYAN}Arch Linux${NONE}."
echo -e ""
echo -e ""
readMotherBoard "- Qual o tipo da placa mãe em que esta instalação está sendo feita?"
echo -e ""
echo -e "- Serão instalados os seguintes pacotes:"
echo -e ""
echo -e "${NONE}Essencial           \tBoot"
echo -e "- ${CYAN}bash${NONE}           \t- ${RED}grub${NONE}  [BIOS]"
echo -e "- ${CYAN}gzip${NONE}           \t- ${RED}grub-efi-x86_64${NONE}"
echo -e "- ${CYAN}pacman${NONE}         \t- ${RED}efibootmgr${NONE}"
echo -e "- ${CYAN}sed${NONE}"
echo -e "- ${CYAN}systemd-sysvcompat${NONE}"
echo -e "- ${CYAN}linux${NONE}"
echo -e ""
echo -e "${NONE}Servidor            \tInternet"
echo -e "- ${YELLOW}sudo${NONE}         \t\t- ${PURPLE}network-manager-applet${NONE}"
echo -e "- ${YELLOW}vim${NONE}          \t\t- ${PURPLE}wget${NONE}"
echo -e "- ${YELLOW}sshfs${NONE}"
echo -e "- ${YELLOW}less${NONE}"
echo -e ""
echo -e ""
readNext "-- Deseja prosseguir?"

if [ "$next" != "SIM" ]; then
  echo ""
  echo "-- Instalação encerrada!"
  echo ""
  echo ""
else
  if [ "$mother_board" == "UEFI" ]; then
    pacstrap /mnt bash gzip pacman sed systemd-sysvcompat linux sudo vim sshfs less grub grub-efi-x86_64 efibootmgr network-manager-applet wget 
  else
    pacstrap /mnt bash gzip pacman sed systemd-sysvcompat linux sudo vim sshfs less grub network-manager-applet wget
  fi



  echo -e ""
  echo -e ""
  echo -e "- Finalizada a instalação dos pacotes básicos terminados."
  readNext "-- Deseja prosseguir?"
  if [ "$next" != "SIM" ]; then
    echo ""
    echo "-- Instalação encerrada!"
    echo ""
    echo ""
  else
    
    echo -e ""
    echo -e ""
    echo -e "- Prepara o arquivo de boot ${CYAN}fstab${NONE}"
    genfstab -U -p /mnt >> /mnt/etc/fstab

    echo -e ""
    echo -e ""
    echo -e "${CYAN}A etapa do instalador finalizou.${NONE}"
    echo -e "${CYAN}Rode os comandos abaixo para completar a instalação.${NONE}"
    echo -e ""
    echo -e "${PURPLE}curl -O https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/install-03.sh${NONE}"
    echo -e "${PURPLE}chmod u+x install-03.sh${NONE}"
    echo -e ""
    echo -e ""
    echo -e "- Switch para o novo sistema."
    arch-chroot /mnt
  fi
fi
