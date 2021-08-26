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
ncr=""





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

## Identifica o nome do computador remoto
readNCR() {
  while [ "$ncr" == "" ]; do
    echo ""
    echo "$1"
    read -p " > " ncr

    if [ "$ncr" == "" ]; then
      echo "   Você precisa digitar um nome válido"
    fi
  done
}





echo -e ""
clear
echo -e ""
echo -e "${CYAN}Arch Linux${NONE}"
echo -e "${CYAN}Etapa 01${NONE} - Preparação do disco."

echo -e ""
echo -e ""


readMotherBoard " - Qual o tipo da placa mãe em que esta instalação está sendo feita?"


echo -e ""
echo -e "${CYAN}01.2${NONE} - Iniciando o sistema de partições."
if [ "$mother_board" == "UEFI" ]; then
  echo -e "${YELLOW}UEFI - GPT${NONE}."
  echo -e "g\nn\n\n\n+512M\nt\n1\nn\n\n\n+512M\nt\n\n19\nn\n\n\n\nw" | fdisk /dev/sda
else
  echo -e "${YELLOW}BIOS - MBR${NONE}."
  echo -e "o\nn\n\n\n+512M\nt\n4\nn\n\n\n+512M\nt\n\n19\nn\n\n\n\nw" | fdisk /dev/sda
fi


echo -e ""
echo -e ""
echo -e "${CYAN}Preparo do sistema de partições concluído; Confira o resultado abaixo.${NONE}"
fdisk -l /dev/sda


echo -e ""
echo -e ""
readNext "-- Deseja prosseguir?"
if [ "$next" != "SIM" ]; then
  echo -e ""
  echo "-- Instalação encerrada!"
  echo -e ""
  echo -e ""
else
  echo -e ""
  echo -e "${CYAN}01.3${NONE} - Formatando as partições."
  mkfs.fat -F32 /dev/sda1
  mkswap /dev/sda2
  mkfs.ext4 /dev/sda3



  echo -e ""
  echo -e ""
  echo -e "${CYAN}01.4${NONE} - Montando as partições e preparando o filesystem."
  mount /dev/sda3 /mnt
  mkdir /mnt/boot
  mkdir /mnt/home
  mount /dev/sda1 /mnt/boot
  swapon /dev/sda2



  echo -e ""
  echo -e ""
  echo -e "${CYAN}Etapa 01${NONE} - Preparação do disco concluída!."
  echo -e ""
  echo -e ""
  readNext "-- Deseja prosseguir?"
  if [ "$next" != "SIM" ]; then
    echo ""
    echo "-- Instalação encerrada!"
    echo ""
    echo ""
  else
    echo -e ""
    clear
    echo -e ""
    echo -e "${CYAN}Etapa 02${NONE} - Instalação dos pacotes iniciais."
    echo -e "           Serão instalados os seguintes pacotes:"
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
      readNext "-- Deseja prosseguir?"
      if [ "$next" != "SIM" ]; then
        echo ""
        echo "-- Instalação encerrada!"
        echo ""
        echo ""
      else
        echo -e ""
        echo -e "${CYAN}02.1${NONE} - Preparando o arquivo de boot fstab"
        genfstab -U -p /mnt >> /mnt/etc/fstab


        echo -e ""
        echo -e ""
        echo -e "${CYAN}Etapa 02${NONE} - Instalação dos pacotes iniciais concluída!."
        echo -e "           Esta parte do processo finalizou."
        echo -e "           Você será levado para a instalação que está sendo preparada e,"
        echo -e "           para concluí-la precisará executar a segunda parte do instalador"
        echo -e "           conforme está demonstrado no exemplo abaixo"
        echo -e ""
        echo -e "> ${GREEN}chmod u+x install.sh${NONE}"
        echo -e "> ${GREEN}./install.sh${NONE}"
        echo -e ""
        echo -e ""
        echo -e "${CYAN}Executando o switch para o novo sistema; execute os comandos indicados acima.${NONE}"

        cp -a issue /mnt/etc/issue

        mkdir /etc/myBashEnvironment
        cp -a 01_variables.sh /mnt/etc/myBashEnvironment/01_variables.sh
        cp -a 02_thirdp_functions_pallete256.sh /mnt/etc/myBashEnvironment/02_thirdp_functions_pallete256.sh
        cp -a 03_functions.sh /mnt/etc/myBashEnvironment/03_functions.sh

        mkdir /etc/skel/myBashConfig
        cp -a aliases.sh /mnt/etc/skel/myBashConfig/aliases.sh
        cp -a prompt.sh /mnt/etc/skel/myBashConfig/prompt.sh
        cp -a bash_users_functions.sh /mnt/etc/bash_users_functions.sh

        cp -a .bash_profile /mnt/etc/skel/.bash_profile
        cp -a .bashrc /mnt/etc/skel/.bashrc
        cp -a .bash_profile /mnt/root/.bash_profile
        cp -a .bashrc /mnt/root/.bashrc

        cp -a install-02.sh /mnt/install.sh
        arch-chroot /mnt
      fi
    fi
  fi
fi
