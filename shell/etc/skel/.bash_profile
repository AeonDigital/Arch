#
# ~./bash_profile
#

timedatectl set-timezone America/Sao_Paulo

NOW=$(date +"%Y-%m-%d %T")
NOWD=$(date +"%Y-%m-%d")
NOWT=$(date +"%T")



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






# Carrega configurações personalizadas ao efetuar login
source ~/.bashrc
