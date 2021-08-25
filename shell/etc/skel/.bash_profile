#
# ~./bash_profile
#

timedatectl set-timezone America/Sao_Paulo

NOW=$(date +"%Y-%m-%d %T")
NOWD=$(date +"%Y-%m-%d")
NOWT=$(date +"%T")

# Uptime do sistema
uptime=`cat /proc/uptime | cut -f1 -d.`
upDays=$((uptime/60/60/24))
upHours=$((uptime/60/60%24))
upMins=$((uptime/60%60))
upSecs=$((uptime%60))


# Informações do sistema
HOSTNAME=`uname -n`
KERNEL=`uname -r`
CPU=`awk -F '[ :][ :]+' '/^model name/ { print $2; exit; }' /proc/cpuinfo`
ARCH=`uname -m`
PACMAN=`checkupdates | wc -l`
DETECTDISK=`mount -v | fgrep 'on / ' | sed -n 's_^\(/dev/[^ ]*\) .*$_\1_p'`
DISC=`df -h | grep $DETECTDISK | awk '{print $5 }'`
MEMORY1=`free -t -m | grep "Mem" | awk '{print $6" MB";}'`
MEMORY2=`free -t -m | grep "Mem" | awk '{print $2" MB";}'`
MEMPERCENT=`free | awk '/Mem/{printf("%.2f% (Used) "), $3/$2*100}'`
MEM="$MEMORY1 / $MEMORY2 - $MEMPERCENT"




# Mensagem de Boas Vindas
clear
echo -e "\e[1;30m
           #####
          #######
           #####\e[00m                 User: \e[1;34m$USER\e[00m
                            Directory: \e[1;34m$PWD\e[00m\e[1;30m
   #####   #####\e[00m                 Date: \e[1;34m$NOW\e[00m\e[1;30m
  ####### #######\e[00m              Uptime: \e[1;34m$upDays days $upHours hours $upMins minutes\e[00m\e[1;30m
   #####   #####\e[00m                  CPU: \e[1;34m$CPU\e[00m
                               Memory: \e[1;34m$MEM\e[00m\e[1;30m
   #####           #####\e[00m     Use Disk: \e[1;34m$DISC (used)\e[00m\e[1;30m
  #######         #######
   #####           #####
\e[00m"
echo  ""



# Carrega configurações personalizadas ao efetuar login
source ~/.bashrc
