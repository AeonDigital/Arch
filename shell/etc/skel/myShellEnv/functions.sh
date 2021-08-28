#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e

























#
# Efetua o registro de funções de usuário aos arrays de controle.
#
# param $1 nome da função
# param $2 descrição da função
#
# return void
registerUserFunction() {
  if [ "$#" != "2" ]; then
    echo "Error: expected 2 arguments"
  else
    length=${#FUNCTION_NAMES[@]}
    FUNCTION_NAMES[length]=$1
    FUNCTION_DESCRIPTIONS[length]=$2
  fi
}



#
# Lista todas as funções de usuário registradas no momento
#
# return void
listUserFunctions() {
  length=${#FUNCTION_NAMES[@]}

  for ((i=0;i<length;i++)); do
    fName=${FUNCTION_NAMES[i]}
    fDesc=${FUNCTION_DESCRIPTIONS[i]}
    num=i+1

    if num < 10 ; then
      num="0${num}"
    fi

    echo -e "${num} :: ${fName}"
    echo -e "    ${fDesc}"
  done
}







# Use para ativar/desativar o UTF8 do seu shell
# Para ativar use: ``terminalUTF8 on``
# Para ativar use: ``terminalUTF8 off``
terminalUTF8() {
  if test ".$1" = ".off" ; then
    printf '\033%%@'
    echo -e "UTF-8 off"
  else
    printf '\033%%G'
    echo -e "UTF-8 on"
    echo -e "\u2705"
  fi
}



thirdPart_print256colours() {
  source ~/myShellEnv/thirdPartFunctions/print256colours.sh || true
}
