#!/bin/bash
# Arch Linux Installer [aeondigital.com.br]
#
# Parte 1 da instalação
#
set -eu



clear
setIMessage "" 1
setIMessage "${CYAN}Arch Linux${NONE}"
setIMessage "${CYAN}Etapa 01${NONE} - Preparação do disco [para placa mãe $TMP_MB]."
alertUser



setIMessage "" 1
setIMessage "${CYAN}01.2${NONE} - Iniciando o sistema de partições."
setIMessage "${CYAN}Etapa 01${NONE} - Preparação do disco para placa mãe $TMP_MB."
if [ "$TMP_MB" == "UEFI" ]; then
  setIMessage "${YELLOW}UEFI - GPT${NONE}."
else
  setIMessage "${YELLOW}BIOS - MBR${NONE}."
fi
alertUser


if [ "$TMP_MB" == "UEFI" ]; then
  echo -e "g\nn\n\n\n+512M\nt\n1\nn\n\n\n+512M\nt\n\n19\nn\n\n\n\nw" | fdisk /dev/sda
else
  echo -e "o\nn\n\n\n+512M\nt\n4\nn\n\n\n+512M\nt\n\n19\nn\n\n\n\nw" | fdisk /dev/sda
fi


setIMessage "" 1
setIMessage "${CYAN}Sistema de partições concluído; Confira o resultado abaixo.${NONE}"
fdisk -l /dev/sda


setIMessage "" 1
setIMessage "Deseja prosseguir?"
promptUser

if [ "$MSE_GB_PROMPT_RESULT" == 0 ]; then
  setIMessage "" 1
  setIMessage "Instalação encerrada"
  alertUser
else

  setIMessage "" 1
  setIMessage "${CYAN}01.3${NONE} - Formatando as partições."
  alertUser

  mkfs.fat -F32 /dev/sda1
  mkswap /dev/sda2
  mkfs.ext4 /dev/sda3



  setIMessage "" 1
  setIMessage "${CYAN}01.4${NONE} - Montando as partições e preparando o filesystem."
  alertUser

  mount /dev/sda3 /mnt
  mkdir /mnt/boot
  mkdir /mnt/home
  mount /dev/sda1 /mnt/boot
  swapon /dev/sda2



  setIMessage "" 1
  setIMessage "${CYAN}Etapa 01${NONE} - Preparação do disco concluída!."
  alertUser



  setIMessage "" 1
  setIMessage "Precione qualquer tecla para prosseguir."
  waitUser





  clear
  setIMessage "" 1
  setIMessage "${CYAN}Arch Linux${NONE}"
  setIMessage "${CYAN}Etapa 02${NONE} - Instalação dos pacotes iniciais [para placa mãe $TMP_MB]."
  alertUser


  setIMessage "" 1
  setIMessage "${CYAN}Etapa 02${NONE} - Instalação dos pacotes iniciais."
  setIMessage "           Serão instalados os seguintes pacotes:"
  setIMessage ""
  setIMessage "${NONE}Essencial\t\tBoot"
  setIMessage "- ${LCYAN}bash${NONE}\t\t- ${LRED}grub${NONE}  [BIOS]"
  setIMessage "- ${LCYAN}gzip${NONE}\t\t- ${LRED}grub-efi-x86_64  [UEFI]${NONE}"
  setIMessage "- ${LCYAN}pacman${NONE}\t\t- ${LRED}efibootmgr  [UEFI]${NONE}"
  setIMessage "- ${LCYAN}sed${NONE}"
  setIMessage "- ${LCYAN}systemd-sysvcompat${NONE}"
  setIMessage "- ${LCYAN}linux${NONE}"
  setIMessage ""
  setIMessage "${NONE}Necessários e recomendados\tCompilador C"
  setIMessage "- ${LGREEN}sudo${NONE}\t\t- ${LBLUE}gcc{$NONE}"
  setIMessage "- ${LGREEN}vim${NONE}\t\t- ${LBLUE}make{$NONE}"
  setIMessage "- ${LGREEN}sshfs${NONE}"
  setIMessage "- ${LGREEN}less${NONE}"
  setIMessage "- ${LGREEN}wget${NONE}\t\tRede e segurança"
  setIMessage "- ${LGREEN}tzdata${NONE}\t\t- ${LPURPLE}network-manager-applet${NONE}"
  setIMessage "- ${LGREEN}pacman-contrib${NONE}\t- ${LPURPLE}iputils${NONE}"
  setIMessage "- ${LGREEN}less${NONE}\t- ${LPURPLE}openssl${NONE}"
  setIMessage "- ${LGREEN}less${NONE}"
  setIMessage "- ${LGREEN}less${NONE}"


  setIMessage "" 1
  setIMessage "Deseja prosseguir?"
  promptUser

  if [ "$MSE_GB_PROMPT_RESULT" == 0 ]; then
    setIMessage "" 1
    setIMessage "Instalação encerrada"
    alertUser
  else

    MSE_GB_PROMPT_RESULT=0
    while [ "$MSE_GB_PROMPT_RESULT" == 0 ]; do
      if [ "$TMP_MB" == "UEFI" ]; then
        pacstrap /mnt bash gzip pacman sed systemd-sysvcompat linux sudo vim sshfs less wget tzdata pacman-contrib grub-efi-x86_64 efibootmgr network-manager-applet
      else
        pacstrap /mnt bash gzip pacman sed systemd-sysvcompat linux sudo vim sshfs less wget tzdata pacman-contrib grub network-manager-applet
      fi

      setIMessage "" 1
      setIMessage "Os pacotes foram instalados?"
      promptUser
    done



    setIMessage "" 1
    setIMessage "${CYAN}02.1${NONE} - Preparando o arquivo de boot fstab"
    alertUser
    genfstab -U -p /mnt >> /mnt/etc/fstab



    setIMessage "" 1
    setIMessage "${CYAN}Etapa 02${NONE} - Instalação dos pacotes iniciais concluída!."
    setIMessage "     Esta parte do processo finalizou."
    setIMessage "     Sua máquina está quase pronta para ser usada."
    setIMessage "     ${CYAN}Executando o switch para o novo sistema; execute os comandos indicados acima.${NONE}"


  fi


fi
