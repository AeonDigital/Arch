#
# ~./bash_profile
#



# Mensagem de Boas Vindas
clear
echo  " "
cat /etc/bash-message-wellcome-01
echo  ""
echo  "    Wellcome  \"$USER\"  :)"
echo  "    You´re in \"${PWD}\"" directory
date +"    %A, %d de %B - %Y [%T (%Z)]"
echo  ""



# Carrega configurações personalizadas ao efetuar login
source ~/.bashrc
