#!/bin/bash
#
# Torne este arquivo executável executando o comando abaixo
# chmod u+x install-01.sh
#
# Execute assim
# ./install-01.sh
#






echo ""
clear

echo -e "- Iniciando a instalação dos pacotes básicos para o ${CYAN}Arch Linux${NONE}."
readMotherBoard "01: Qual o tipo da placa mãe em que esta instalação está sendo feita?"
echo -e ""
echo -e "02: Serão instalados os seguintes pacotes:"
echo -e ""
echo -e "${NONE}Essencial              \tBoot [BIOS]"
echo -e "- ${CYAN}bash${NONE}          \t- ${RED}grub${NONE}"
echo -e "- ${CYAN}linux${NONE}"
echo -e "- ${CYAN}pacman${NONE}        \tBoot [UEFI]"
echo -e "- ${CYAN}sed${NONE}           \t- ${RED}grub-efi-x86_64${NONE}"
echo -e "- ${CYAN}systemd-sysvcompat${NONE}   \t- ${RED}efibootmgr${NONE}"
echo -e ""
echo -e "${NONE}Servidor\t\tInternet"
echo -e "- ${YELLOW}sudo${NONE}        \t\t- ${PURPLE}network-manager-applet${NONE}"
echo -e "- ${YELLOW}sshfs${NONE}       \t\t- ${PURPLE}wireless_tools${NONE}"
echo -e "- ${YELLOW}vim${NONE}         \t\t- ${PURPLE}wpa_supplicant${NONE}"
echo -e "                        - ${PURPLE}wget${NONE}"
readNext "-- Deseja prosseguir?"

if [ "$next" != "SIM" ]; then
  echo ""
  echo "-- Instalação encerrada!"
  echo ""
  echo ""
else
  #pacstrap -i /mnt base bash linux pacman sed systemd-sysvcompat grub sudo sshfs vim network-manager-applet wireless_tools wpa_supplicant wget

  echo -e ""
  echo -e "03: Prepara o arquivo de boot ${CYAN}fstab${NONE}"
  #genfstab -U -p /mnt >> /mnt/etc/fstab

  echo -e ""
  echo -e "04: Switch para o novo sistema."
  #arch-chroot /mnt

  echo -e ""
  if [ "$mother_board" == "BIOS" ]; then
    echo -e "05: Efetua a instalação do grub em ${CYAN}BIOS${NONE}."
    #grub-install --target=i386-pc --recheck /dev/sda
  else
    echo -e "05: Efetua a instalação do grub em ${CYAN}UEFI${NONE}."
    #grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch_grub --recheck
  fi

  echo -e ""
  echo -e "06: Configurando o grub."
  #mkdir /boot/grub/locale
  #cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
  #grub-mkconfig -o /boot/grub/grub.cfg

  echo -e ""
  echo -e "07: Seu computador está pronto para ser reiniciado."
  echo -e ""

  readNext "-- Deseja efetuar o reboot agora?"

  if [ "$next" == "SIM" ]; then
    echo ""
    echo "-- Fim da execução! Reiniciando..."
    echo ""
    echo ""
    #exit
    #umount -R /mnt
    #reboot
  else
    echo ""
    echo "-- Fim da execução!"
    echo ""
    echo ""
  fi
fi








echo -e "Para prosseguir você precisa estar com internet configurada no dispositivo."
echo -e "Dispositivos conectados via cabo terão a internet conectada instantaneamente pelo instalador do ${CYAN}Arch Linux${NONE}."
echo -e "Se você precisa conectar em uma rede wi-fi é necessário configurar a conexão usando o comando 'wifi-menu'."

readNext "-- Este dispositivo está conectado  ?"
