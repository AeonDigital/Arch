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
echo -e "${CYAN}Etapa 03${NONE} - Configuração do sistema."

echo -e ""
echo -e ""


readMotherBoard " - Qual o tipo da placa mãe em que esta instalação está sendo feita?"
if [ "$mother_board" == "UEFI" ]; then
  grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
else
  grub-install --target=i386-pc --recheck /dev/sda
fi



cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
grub-mkconfig -o /boot/grub/grub.cfg



echo -e ""
echo -e ""
echo -e "${CYAN}03.1${NONE} - Configure uma senha para o usuário root"
passwd



echo -e ""
echo -e ""
echo -e "${CYAN}03.2${NONE} - Definindo o fuso-horário para 'America/Sao_Paulo'"
timedatectl set-timezone America/Sao_Paulo



echo -e ""
echo -e ""
echo -e "${CYAN}03.3${NONE} - Habilitando o idioma pt-BR; Configurando Layout do teclado e Fonte"
sed -i 's/#pt_BR.UTF-8 UTF-8/pt_BR.UTF-8 UTF-8/g' /etc/locale.gen
echo LANG=pt_BR.UTF-8 >> /etc/locale.conf
echo KEYMAP=br-abnt2 >> /etc/vconsole.conf
echo FONT=lat1-16 >> /etc/vconsole.conf



echo -e ""
echo -e ""
echo -e "${CYAN}03.4${NONE} - Configurar o nome do computador e o arquivo 'hosts'"
readNCR " - Qual o nome deste computador?"
echo "$ncr" >> /etc/hostname
echo 127.0.0.1       localhost.localdomain   localhost >> /etc/hosts
echo ::1             localhost.localdomain   localhost >> /etc/hosts
echo 127.0.0.1       "$ncr".localdomain "$ncr" >> /etc/hosts



echo -e ""
echo -e ""
echo -e "${CYAN}03.5${NONE} - Libera o grupo 'wheel' para que ele seja um 'sudoer'"
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g' /etc/sudoers



echo -e ""
echo -e ""
echo -e "${CYAN}03.6${NONE} - Ativa a internet"
systemctl enable NetworkManager
#systemctl start NetworkManager



echo -e ""
echo -e ""
echo -e "${CYAN}03.7${NONE} - Configura a 'tela de login' do sistema"
> /etc/issue
echo "\e[37m    Arch \s (\m ver. \r :: \l) \e[00m
\e[1;30m    \v
  __________________________________________________________
        __   ____  __   __ _  
       / _\\\\ (  __)/  \\\\ (  ( \\\\  
      /    \\\\ ) _)(  O )/    /  
      \\\\_/\\\\_/(____)\\\\__/ \\\\_)__)  
               ____  __  ___  __  ____  __   __  
              (    \\\\(  )/ __)(  )(_  _)/ _\\\\ (  )  
               ) D ( )(( (_ \\\\ )(   )( /    \\\\/ (_/\\\\  
              (____/(__)\\\\___/(__) (__)\\\\_/\\\\_/\\\\____/ 
                         http://aeondigital.com.br 
  __________________________________________________________
\e[00m
                Machine
      Name:\e[1;30m \n \e[00m
    Domain:\e[1;30m \o \e[00m
      Date:\e[1;30m \d  \t 
  __________________________________________________________
\e[00m
" >> /etc/issue



echo -e ""
echo -e ""
echo -e "${CYAN}03.7${NONE} - Seu computador está pronto para ser reiniciado."



readNext "-- Deseja efetuar o reboot agora?"
if [ "$next" == "SIM" ]; then
  echo ""
  echo -e "${CYAN}Etapa 03${NONE} - Configuração do sistema concluída!."
  echo -e "           Rode os comandos abaixo para executar o reboot."
  echo -e ""
  echo -e "${GREEN}exit${NONE}"
  echo -e "${GREEN}umount -R /mnt${NONE}"
  echo -e "${GREEN}reboot${NONE}"
  echo ""
  echo ""
  rm install.sh
else
  echo ""
  echo "-- Fim da execução!"
  echo ""
  echo ""
fi
