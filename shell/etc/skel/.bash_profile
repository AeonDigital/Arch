#
# ~./bash_profile
#



timedatectl set-timezone America/Sao_Paulo
source /etc/bash_01_env_variables.sh || true
source /etc/bash_02_env_functions.sh || true
source /etc/bash_03_session_pallete256.sh || true
source /etc/bash-function-user.sh || true



#
# Mensagem de Boas Vindas
clear
LOAD_BASHRC=1

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
# Dá a chance do root optar por carregar ou não os scripts
# de personalização
#
if [ "$USER" == "root" ]; then
  PROMPT_MSG[0]=$(printf "\e[01;37mDeseja carregar scripts iniciais?\e[00m")

  promptUser
  LOAD_BASHRC=${PROMPT_RESULT}
  PROMPT_RESULT=""
fi



#
# Carrega configurações personalizadas ao efetuar login
#
if [ "$LOAD_BASHRC" == 1 ]; then
  source ~/.bashrc || true
else
  PS1="\[\e[40;00;37m\]\$ \[\e[40;01;30m\]\u\[\e[40;00;37m\]@\[\e[40;01;30m\]\h : \[\e[40;00;37m\]"
fi
