#
# ~./bash_profile
#

timedatectl set-timezone America/Sao_Paulo


NONE="\e[00m"

BLACK="\e[30m"
DGREY="\e[1;30m"
LGREY="\e[1;37m"
WHITE="\e[37m"

RED="\e[31m"
LRED="\e[1;31m"

GREEN="\e[32m"
LGREEN="\e[1;32m"

BROWN="\e[33m"
YELLOW="\e[1;33m"

BLUE="\e[34m"
LBLUE="\e[1;34m"

PURPLE="\e[35m"
LPURPLE="\e[1;35m"

CYAN="\e[36m"
LCYAN="\e[1;36m"



# Mensagem de Boas Vindas
clear
echo  -e "${LCYAN} 
           #####
          #######
           #####

   #####   #####      
  ####### #######${NONE}     Wellcome ${CYAN}$USER${NONE}  :)${CYAN}
   #####   #####${NONE}      You´re in ${CYAN}${PWD}${NONE} directory${CYAN}

   #####           #####
  #######         #######
   #####           #####
${NONE}"
date +"  %A, %d de %B - %Y [%T (%Z)]"
echo  ""
echo  ""



# Carrega configurações personalizadas ao efetuar login
source ~/.bashrc
