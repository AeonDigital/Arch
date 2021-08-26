#
# ~./bash_profile
#

timedatectl set-timezone America/Sao_Paulo

NOW=$(date +"%Y-%m-%d %T")
NOWD=$(date +"%Y-%m-%d")
NOWT=$(date +"%T")


# Variáveis de uso geral
PROMPT_OPTIONS="sim(s) | nao(n)"
PROMPT_MSG=()
PROMPT_INDENT="    "
PROMPT_RESULT=""
BASH_PERSONALIZE=1


# Informações do sistema
KERNEL=`uname -r`
ARCH=`uname -m`
CPU=`awk -F '[ :][ :]+' '/^model name/ { print $2; exit; }' /proc/cpuinfo`

MEMORY1=`free -t -m | grep "Mem" | awk '{print $6" MB";}'`
MEMORY2=`free -t -m | grep "Mem" | awk '{print $2" MB";}'`
MEMPERCENT=`free | awk '/Mem/{printf("%.2f% (Used) "), $3/$2*100}'`

DETECTDISK=`mount -v | fgrep 'on / ' | sed -n 's_^\(/dev/[^ ]*\) .*$_\1_p'`
DISC=`df -h | grep $DETECTDISK | awk '{print $5 }'`

UP=`uptime -p`
PACMAN=`checkupdates | wc -l`
HOSTNAME=`uname -n`




# Mensagem de Boas Vindas
clear

echo -e "\e[37m  Arch Linux $KERNEL $ARCH \e[00m
\e[1;30m
           #####
          #######
           #####\e[00m                  CPU: \e[1;34m$CPU\e[00m
                               Memory: \e[1;34m$MEMORY1 / $MEMORY2 - $MEMPERCENT\e[00m\e[1;30m
   #####   #####\e[00m             Use Disk: \e[1;34m$DISC (used)\e[00m\e[1;30m
  ####### #######\e[00m              Uptime: \e[1;34m$UP\e[00m\e[1;30m
   #####   #####\e[00m               Pacman: \e[1;34m$PACMAN packages can be updated\e[00m\e[1;30m
                               
   #####           #####\e[00m         User: \e[1;34m$USER\e[00m\e[1;30m
  #######         #######\e[00m        Host: \e[1;34m$HOSTNAME\e[00m\e[1;30m
   #####           #####\e[00m         Date: \e[1;34m$NOW\e[00m

"





#
# Converte o argumento passado para minúsculas.
#
#   param string $1 string que será convertida
#   example
#     result=$(toLowerCase "TEXT")
#
toLowerCase() {
  echo "${1,,}"
}
#
# Converte o argumento passado para maiúsculas.
#
#   param string $1 string que será convertida.
#   example
#     result=$(toUpperCase "TEXT")
#
toUpperCase() {
  echo "${1^^}"
}
#
# Mostra uma mensagem para o usuário e questiona sobre Sim ou Não
# A mensagem mostrada deve ser preparada no array ${PROMPT_MSG}
# onde, cada item do array será definido em uma linha do terminal.
#
# O resultado selecionado pelo usuário ficará definido na variável ${PROMPT_RESULT}
# armazenando os valores:
#   0 : nao(n)
#   1 : sim(s)
#
#   example
#     PROMPT_MSG=()
#     PROMPT_MSG[0]=$(printf "${SILVER}ATENÇÃO!${NONE}")
#     PROMPT_MSG[0]=$(printf "Deseja prosseguir?")
#
#     promptUser 
#     if [ "$PROMPT_RESULT" == "1" ]; then
#       echo "Escolhido Sim"
#     else
#       echo "Escolhido Não"
#     fi
#
promptUser() {
  PROMPT_RESULT=""

  
  if [ ${#PROMPT_MSG[@]} = 0 ]; then
    echo -e "\e[01;37mERROR (fn promptUser): empty array \e[01;32mPROMPT_MSG\e[00m"
    echo -e ""
  else
  
    while [ "$PROMPT_RESULT" != "sim" ] && [ "$PROMPT_RESULT" != "s" ] && [ "$PROMPT_RESULT" != "nao" ] && [ "$PROMPT_RESULT" != "n" ]; do
      if [ "$PROMPT_RESULT" != "" ]; then
        echo "   Esperado apenas [ ${PROMPT_OPTIONS} ]: \"$PROMPT_RESULT\""
      fi

      echo ""
      for msg in "${PROMPT_MSG[@]}"; do 
        echo "${PROMPT_INDENT}$msg"
      done

      read -p "${PROMPT_INDENT}[ ${PROMPT_OPTIONS} ] : " PROMPT_RESULT
      PROMPT_RESULT=$(toLowerCase "$PROMPT_RESULT")
    done


    if [ "$PROMPT_RESULT" == "nao" ] || [ "$PROMPT_RESULT" == "n" ]; then
      PROMPT_RESULT=0
    fi

    if [ "$PROMPT_RESULT" == "sim" ] || [ "$PROMPT_RESULT" == "s" ]; then
      PROMPT_RESULT=1
    fi

  fi
}




#
# Dá a chance do root optar por carregar ou não os scripts
# de personalização
#
if [ "$USER" == "root" ]; then
  PROMPT_MSG=()
  PROMPT_MSG[0]=$(printf "\e[01;37mDeseja carregar scripts iniciais?\e[00m")

  promptUser 
  BASH_PERSONALIZE=${PROMPT_RESULT}
  PROMPT_RESULT=""
fi



#
# Carrega configurações personalizadas ao efetuar login
#
if [ "$BASH_PERSONALIZE" == 1 ]; then
  source ~/.bashrc || true
else
  PS1="\[\e[40;00;37m\]\$ \[\e[40;01;30m\]\u\[\e[40;00;37m\]@\[\e[40;01;30m\]\h : \[\e[40;00;37m\]"
fi
