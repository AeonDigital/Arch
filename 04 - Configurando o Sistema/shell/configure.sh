#!/bin/bash


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
next=""
hostname=""
wifiSSID=""
wifiPW=""



# Funções
## Converte o argumento passado para minusculas
toLowerCase() {
  echo "${1,,}"
}

## Converte o argumento passado para maiusculas
toUpperCase() {
  echo "${1^^}"
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

## Lê o nome do computador na rede
readHostName() {
  while [ "$hostname" != "BIOS" ] && [ "$hostname" != "UEFI" ]; do
    if [ "$hostname" == "" ]; then
      echo "   Você precisa definir o nome deste computador na rede."
    fi

    echo ""
    read -p "$1" hostname
    hostname=$(toLowerCase "$hostname")
  done
}

## Seleciona a rede WiFi na qual o computador deve ser conectado
selectWiFi() {

}






echo -e "Iniciando a configuração do ${CYAN}Arch Linux${NONE}."
echo -e "Os seguintes itens erão definidos:"
echo -e "  - Encode: ${CYAN}UTF-8${NONE}"
echo -e "  - Lingua: ${CYAN}pt-BR${NONE}"
echo -e "  - Teclado: ${CYAN}br-abnt2${NONE}"
echo -e "  - Fonte padrão: ${CYAN}lat1-16${NONE}"
readNext "-- Deseja prosseguir?"


if [ "$next" != "SIM" ]; then
  echo ""
  echo "-- Configuração encerrada!"
  echo ""
  echo ""
else
  readHostName "-- Defina o nome deste computador na rede: "


  echo -e "01: Definindo o fuso-horário para ${CYAN}São Paulo${NONE}"
  mkdir /etc/localtime
  ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
  echo -e "... ${GREEN}OK${NONE}"

  echo -e "02: Sincronizando o clock do sistema com o da placa-mae."
  hwclock --systohc --utc
  echo -e "... ${GREEN}OK${NONE}"

  echo -e "03: Habilitando o idioma \"${CYAN}pt-BR${NONE}\""
  sed -i "/^#.*pt_BR.UTF-8 UTF-8/s/^#//" /etc/locale.gen
  locale-gen
  echo -e "... ${GREEN}OK${NONE}"

  echo -e "04: Definir a lingua e encode padrão em \"${CYAN}locale.conf${NONE}\""
  echo LANG=pt_BR.UTF-8 >> /etc/locale.conf
  echo -e "... ${GREEN}OK${NONE}"

  echo -e "05: Configurar o teclado para \"${CYAN}br-abnt2${NONE}\""
  echo KEYMAP=br-abnt2 >> /etc/vconsole.conf
  echo -e "... ${GREEN}OK${NONE}"

  echo -e "06: Configurar a fonte do terminal para \"${CYAN}lat1-16${NONE}\""
  echo FONT=lat1-16 >> /etc/vconsole.conf
  echo -e "... ${GREEN}OK${NONE}"

  echo -e "07: Configurando o nome do computador na rede"
  echo $1 >> /etc/hostname
  echo "127.0.0.1         localhost.localdomain   localhost" >> /etc/hosts
  echo "::1               localhost.localdomain   localhost" >> /etc/hosts
  echo "127.0.0.1         $next.localdomain       $next" >> /etc/hosts
  echo -e "... ${GREEN}OK${NONE}"

  echo -e "08: Configure a senha do usuário \"${CYAN}root${NONE}\""
  echo -e "   Lembre de anotar esta senha pois ela lhe será útil!"
  passwd


  readNext "-- Deseja configurar uma rede ${CYAN}wi-fi${NONE}?"
  if [ "$next" == "SIM" ]; then
    echo "-- As seguintes redes estão disponíveis:"
    nmcli device wifi list

    echo "-- Use o seguinte comando para "
    # nmcli device wifi connect [SSID] password [senha]

    sudo systemctl enable NetworkManager
    sudo systemctl start NetworkManager
  fi


  readNext "-- Deseja habilitar o ${CYAN}SSH${NONE} para se conectar remotamente neste computador?"
  if [ "$next" == "SIM" ]; then
    sudo systemctl enable sshd 
    sudo systemctl restart sshd
  fi
  

  echo -e "09: Excluindo o histórico do bash"
  rm ~/.bash_history
fi
