#
# ~./bash_profile
#



# Mensagem de Boas Vindas
clear

NONE="\033[00m"
BLUE="\033[34m"
PURPLE="\033[35m"
CYAN="\033[36m"

echo  "${CYAN} 
           #####
          #######
           #####

   #####   #####      
  ####### #######${NONE}     Wellcome ${PURPLE}$USER${NONE}  :)${CYAN}
   #####   #####${NONE}      You´re in ${PURPLE}${PWD}${NONE} directory${CYAN}

   #####           #####
  #######         #######
   #####           #####
${NONE}"
date +"  %A, %d de %B - %Y [%T (%Z)]"
echo  ""



# Carrega configurações personalizadas ao efetuar login
source ~/.bashrc
