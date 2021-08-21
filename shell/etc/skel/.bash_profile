#
# ~./bash_profile
#



# Mensagem de Boas Vindas
clear
echo  " "
cat /etc/bash-message-wellcome
echo  ""
date +"          %A, %d de %B - %Y [%T (%Z)]"
echo  "          Bem Vind@ $USER  :)"
echo  "          Você está em : \"${PWD}\""
echo  ""



# Carrega configurações personalizadas ao efetuar login
source ~/.bashrc
