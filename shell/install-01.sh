#!/bin/bash
#
# Torne este arquivo executável executando o comando abaixo
# chmod u+x install-02.sh
#
# Execute assim
# ./install-02.sh
#






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
