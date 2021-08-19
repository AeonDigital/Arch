#!/bin/bash
#
# Torne este arquivo executável executando o comando abaixo
# chmod u+x install-02.sh
#
# Execute assim
# ./install-02.sh
#






echo ""
clear

echo -e "- Preparando o disco para instalação do ${CYAN}Arch Linux${NONE}."
echo ""
echo ""
readMotherBoard "01: Qual o tipo da placa mãe em que esta instalação está sendo feita?"
readNext "-- Deseja prosseguir?"

if [ "$next" != "SIM" ]; then
  echo ""
  echo "-- Instalação encerrada!"
  echo ""
  echo ""
else
  echo -e ""
  echo -e "02: Preparando a unidade de armazenamento persistente"
  if [ "$mother_board" == "UEFI" ]; then
    echo -e "    Preparando para receber sistema usando placa mãe do tipo ${CYAN}UEFI - GPT${NONE}."
    echo -e "g\nn\n\n\n+512M\nt\n1\nn\n\n\n+512M\nt\n\n19\nn\n\n\n\nw" | fdisk /dev/sda
  else
    echo -e "    Preparando para receber sistema usando placa mãe do tipo ${CYAN}BIOS - MBR${NONE}."
    echo -e "o\nn\n\n\n+512M\nt\n4\nn\n\n\n+512M\nt\n\n19\nn\n\n\n\nw" | fdisk /dev/sda
  fi


  echo -e "Preparo da unidade de armazenamento persistente concluído:"
  fdisk -l /dev/sda

  readNext "-- Deseja prosseguir?"
  if [ "$next" != "SIM" ]; then
    echo ""
    echo "-- Instalação encerrada!"
    echo ""
    echo ""
  else
    echo -e ""
    echo -e "03: Formatando as partições criadas"
    mkfs.fat -F32 /dev/sda1
    mkswap /dev/sda2
    mkfs.ext4 /dev/sda3


    echo ""
    echo ""

    echo -e "04: Montando as partições e preparando o filesystem"
    mount /dev/sda3 /mnt
    mkdir /mnt/boot 
    mkdir /mnt/home
    mount /dev/sda1 /mnt/boot
    swapon /dev/sda2


    echo ""
    echo ""

    echo -e "${CYAN}Processo de configuração do disco finalizado${NONE}."
    echo -e "- Use o comando abaixo para prosseguir."
    echo -e "${CYAN}install-02.sh${NONE}"
    echo ""
    echo ""
  fi
fi
