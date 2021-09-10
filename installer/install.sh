#!/bin/bash
# Arch Linux Installer [aeondigital.com.br]
#
# Torne este arquivo executável executando o comando abaixo
# chmod u+x install.sh
#
# Execute assim
# ./install.sh
#
set -eu





#
# Questiona ao usuário sobre o tipo de placa mãe
# na qual a instalação será feita.
readMotherBoard() {
  while [ "$TMP_MB" != "BIOS" ] && [ "$TMP_MB" != "UEFI" ]; do
    if [ "$TMP_MB" != "" ]; then
      setIMessage "\n" 1
      setIMessage "O tipo de placa mãe informado é inválido: \"$TMP_MB\"."
      alertUser
    fi

    setIMessage "\n" 1
    setIMessage "Qual o tipo da placa mãe em que a instalação está sendo feita?"
    alertUser

    read -p "   [ BIOS | UEFI ] : " TMP_MB
    TMP_MB=$(echo "$TMP_MB" | awk '{print toupper($0)}')
  done
}



#
# Identifica o nome a ser usado o computador na rede
# 
readNCR() {
  while [ "$TMP_CR" == "" ]; do
    setIMessage "\n" 1
    setIMessage "Qual o nome deste computador na rede?"
    alertUser

    read -p " > " TMP_CR

    if [ "$TMP_CR" == "" ]; then
      setIMessage "\n" 1
      setIMessage "Você precisa digitar um nome válido."
      alertUser
    fi
  done
}





#
# Efetua o download de todos os scripts necessários para a instalação
loadkeys br-abnt2


ISOK=1
TMP_MB=""
TMP_CR=""

TMP_INTERFACE_URL="https://raw.githubusercontent.com/AeonDigital/myShellEnv/main/etc/skel/myShellEnv/functions/interface/"
TMP_INTERFACE=(
  "textColors.sh" "alertUser.sh" "errorAlert.sh"
  "waitUser.sh" "promptUser.sh" "setIMessage.sh"
)

TMP_SCODE=""
TMP_TGT_URL=""
TMP_URL_BASE="https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/installer/"
TMP_FILE_NAME=""



mkdir -p "tmpInstaller"
if [ ! -d "tmpInstaller" ]; then
  ISOK=0

  printf "    Não foi possível criar o diretório temporário de instalação. \n"
  printf "    A instalação foi encerrada.\n"
else
  
  for TMP_FILE_NAME in "${TMP_INTERFACE[@]}"; do
    if [ $ISOK == 1 ]; then
      TMP_TGT_URL="${TMP_INTERFACE_URL}${TMP_FILE_NAME}"
      TMP_SCODE=$(curl -s -w "%{http_code}" -o "tmpInstaller/${TMP_FILE_NAME}" "${TMP_TGT_URL}" || true)

      if [ ! -f "tmpInstaller/${TMP_FILE_NAME}" ] || [ $TMP_SCODE != 200 ]; then
        ISOK=0

        printf "    Não foi possível fazer o download do arquivo de instalação '${TMP_FILE_NAME}'\n"
        printf "    A instalação foi encerrada.\n"
        printf "    URL: ${TMP_TGT_URL} \n"
        printf "    TGT: ${TMP_FILE_NAME} \n\n"        
      else
        printf "    > Carregando script: ${TMP_FILE_NAME} \n"
        source "tmpInstaller/${TMP_FILE_NAME}"
      fi
    fi
  done

  setIMessage "Teste" 1
fi



if [ $ISOK == 1 ]; then
  TMP_FILE_NAME="installerPart01.sh"
  TMP_TGT_URL="${TMP_URL_BASE}${TMP_FILE_NAME}"
  TMP_SCODE=$(curl -s -w "%{http_code}" -O "${TMP_TGT_URL}" || true)

  if [ ! -f "${TMP_FILE_NAME}" ] || [ $TMP_SCODE != 200 ]; then
    ISOK=0

    printf "    Não foi possível fazer o download do arquivo de instalação '${TMP_FILE_NAME}'\n"
    printf "    A instalação foi encerrada.\n"
    printf "    URL: ${TMP_TGT_URL} \n"
    printf "    TGT: ${TMP_FILE_NAME} \n\n"        
  else
    chmod u+x "${TMP_FILE_NAME}"
  fi
fi

if [ $ISOK == 1 ]; then
  TMP_FILE_NAME="installerPart02.sh"
  TMP_TGT_URL="${TMP_URL_BASE}${TMP_FILE_NAME}"
  TMP_SCODE=$(curl -s -w "%{http_code}" -O "${TMP_TGT_URL}" || true)

  if [ ! -f "${TMP_FILE_NAME}" ] || [ $TMP_SCODE != 200 ]; then
    ISOK=0

    printf "    Não foi possível fazer o download do arquivo de instalação '${TMP_FILE_NAME}'\n"
    printf "    A instalação foi encerrada.\n"
    printf "    URL: ${TMP_TGT_URL} \n"
    printf "    TGT: ${TMP_FILE_NAME} \n\n"        
  else
    chmod u+x "${TMP_FILE_NAME}"
  fi
fi





if [ $ISOK == 1 ]; then

  setIMessage "" 1
  setIMessage "Scripts de instalação foram baixados e preparados para uso..."
  alertUser



  #
  # Questiona o usuário sobre o tipo de placa mãe na qual a instalação será feita.
  readMotherBoard

  #
  # Questiona o usuário sobre qual será o nome do computador na rede.
  readNCR



  printf "$TMP_MB" > "tmpInstaller/varTMP_MB"
  printf "$TMP_CR" > "tmpInstaller/varTMP_CR"
fi




ISOK=1
unset TMP_MB
unset TMP_CR

unset TMP_SCODE
unset TMP_TGT_URL
unset TMP_URL_BASE
unset TMP_FILE_NAME


unset downloadInstallScripts
unset createTmpInstallerEnv
unset readMotherBoard 
unset readNCR


if [ $ISOK == 1 ]; then
  source installerPart01.sh
fi
