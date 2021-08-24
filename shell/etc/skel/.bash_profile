#
# ~./bash_profile
#


timedatectl set-timezone America/Sao_Paulo
NOW=$(date + "$Y-%m-%d")

NONE="\033[00m"
CYAN="\033[36m"



# Mensagem de Boas Vindas
clear
echo  -e "${CYAN} 
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
