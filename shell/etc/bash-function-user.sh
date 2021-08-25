#!/bin/bash

# Use este script para adicionar funções que deseja disponibilizar para todas as 
# seções dos usuários desta máquina.


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
