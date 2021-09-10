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
# Efetua o download de scripts necessários para a instalação.
# Em caso de falha, altera o valor da variável de controle ${ISOK} para "0".
# Sendo bem sucedido irá carregar o script.
#
#   @param string $1
#   Nome do script a ser salvo no diretório temporário 'tmpInstaller'.
#
#   @param string $2
#   Url onde está o arquivo a ser baixado.
#
#   @example
#     downloadInstallScripts "textColors.sh" "textColors.sh"
#
downloadInstallScripts() {
  if [ $# != 2 ]; then
    printf "ERROR in ${FUNCNAME[0]}: expected 2 arguments"
  else
    local mseTMP="${HOME}/tmpInstaller/$1"
    local mseSCode=$(curl -s -w "%{http_code}" -o "${mseTMP}" "$2" || true)

    if [ ! -f "$mseTMP" ] || [ $mseSCode != 200 ]; then
      ISOK=0

      printf "    Não foi possível fazer o download do arquivo de instalação '$1'\n"
      printf "    A instalação foi encerrada.\n"
      printf "    TGT: ${mseTMP} \n"
      printf "    URL: $2 \n\n"
    else
      printf "    > Carregando script: ${mseTMP} \n"
      source "${mseTMP}"
    fi
  fi
}



#
# Efetua o download dos scripts mínimos necessários para efetuar a
# instalação.
#
# Um diretório chamado 'tmpInstaller' será criado no diretório $HOME do
# usuário que iniciou a instalação e nele serão alocados scripts que
# permitem o seguimento da instalação.
#
createTmpInstallerEnv() {

  mkdir -p "${HOME}/tmpInstaller"
  if [ ! -d "${HOME}/tmpInstaller" ]; then
    ISOK=0

    printf "    Não foi possível criar o diretório temporário de instalação. \n"
    printf "    A instalação foi encerrada.\n"
  else
    if [ $ISOK == 1 ]; then
      local mseInstallFiles=(
        "textColors.sh" "alertUser.sh" "errorAlert.sh"
        "waitUser.sh" "promptUser.sh" "setIMessage.sh"
      )

      local mseURLInterface="https://raw.githubusercontent.com/AeonDigital/myShellEnv/main/etc/skel/myShellEnv/functions/interface/"
      local mseFileName
      for mseFileName in "${mseInstallFiles[@]}"; do
        if [ $ISOK == 1 ]; then
          downloadInstallScripts "${mseFileName}" "${mseURLInterface}${mseFileName}"
        fi
      done
    fi
  fi
}



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
ISOK=1
TMP_MB=""
TMP_CR=""

TMP_URL_BASE="https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/installer/"

TMP_TGT_URL=""
TMP_FILE_NAME=""
TMP_FILE_LOCAL=""
TMP_SCODE=""



loadkeys br-abnt2
createTmpInstallerEnv


if [ $ISOK == 1 ]; then
  TMP_FILE_NAME="installerPart01.sh"
  TMP_FILE_LOCAL="${TMP_FILE_NAME}"
  TMP_TGT_URL="${TMP_URL_BASE}/tmpInstaller/${TMP_FILE_NAME}"
  
  TMP_SCODE=$(curl -s -w "%{http_code}" -o "${TMP_FILE_LOCAL}" "${TMP_TGT_URL}" || true)

  if [ ! -f "$TMP_FILE_LOCAL" ] || [ $TMP_SCODE != 200 ]; then
    chmod u+x "${TMP_FILE_LOCAL}"
  else
    ISOK=0

    printf "    Não foi possível fazer o download do arquivo de instalação 'installerPart01.sh'\n"
    printf "    A instalação foi encerrada.\n"
    printf "    FILE: ${TMP_FILE_NAME} \n"
    printf "    URL: ${TMP_TGT_URL} \n\n"
  fi
fi

if [ $ISOK == 1 ]; then
  TMP_FILE_NAME="installerPart02.sh"
  TMP_FILE_LOCAL="${TMP_FILE_NAME}"
  TMP_TGT_URL="${TMP_URL_BASE}/tmpInstaller/${TMP_FILE_NAME}"
  
  TMP_SCODE=$(curl -s -w "%{http_code}" -o "${TMP_FILE_LOCAL}" "${TMP_TGT_URL}" || true)

  if [ ! -f "$TMP_FILE_LOCAL" ] || [ $TMP_SCODE != 200 ]; then
    chmod u+x "${TMP_FILE_LOCAL}"
  else
    ISOK=0

    printf "    Não foi possível fazer o download do arquivo de instalação 'installerPart01.sh'\n"
    printf "    A instalação foi encerrada.\n"
    printf "    FILE: ${TMP_FILE_NAME} \n"
    printf "    URL: ${TMP_TGT_URL} \n\n"
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



  printf "$TMP_MB" > "/tmpInstaller/varTMP_MB"
  printf "$TMP_CR" > "/tmpInstaller/varTMP_CR"
fi




ISOK=1
unset TMP_MB
unset TMP_CR

unset TMP_URL_BASE

unset TMP_TGT_URL
unset TMP_FILE_NAME
unset TMP_FILE_LOCAL
unset TMP_SCODE


unset downloadInstallScripts
unset createTmpInstallerEnv
unset readMotherBoard 
unset readNCR


if [ $ISOK == 1 ]; then
  ./installerPart01.sh
fi
