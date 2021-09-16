#!/bin/bash
# Arch Linux Installer [aeondigital.com.br]
#
# Parte 2 da instalação
#
set -eu



TMP_INTERFACE=(
  "textColors.sh" "alertUser.sh" "errorAlert.sh"
  "waitUser.sh" "promptUser.sh" "setIMessage.sh"
)
for TMP_FILE_NAME in "${TMP_INTERFACE[@]}"; do
  source "tmpInstaller/${TMP_FILE_NAME}"
done


#
# Inicia arquivos de configuração do sistema
# que serão utilizados
printf "" > /etc/locale.conf
printf "" > /etc/vconsole.conf
printf "" > /etc/hostname
printf "" > /usr/local/bin/numlock
printf "" > /etc/systemd/system/numlock.service





clear
setIMessage "" 1
setIMessage "${CYAN}Arch Linux${NONE}"
setIMessage "${CYAN}Etapa 03${NONE} - Configuração do sistema."
setIMessage ""
alertUser


setIMessage " - Definindo o fuso-horário para ${WHITE}'America/Sao_Paulo'${NONE}" 1
alertUser
timedatectl set-timezone America/Sao_Paulo



setIMessage " - Habilitando o locale ${WHITE}'pt-BR'${NONE}" 1
alertUser
sed -i 's/#pt_BR.UTF-8 UTF-8/pt_BR.UTF-8 UTF-8/g' /etc/locale.gen
printf "LANG=pt_BR.UTF-8\n" >> /etc/locale.conf
locale-gen "pt_BR.UTF-8"
#export LC_ALL="pt_BR.UTF-8"



setIMessage " - Configurando Layout do teclado ${WHITE}'abnt2'${NONE}" 1
alertUser
printf "KEYMAP=br-abnt2\n" > /etc/vconsole.conf



setIMessage " - Configurando fonte compatível com caracteres latinos" 1
alertUser
printf "FONT=lat1-16\n" >> /etc/vconsole.conf



TMP_CR=$(cat "tmpInstaller/varTMP_CR")
setIMessage " - Configurar o nome do computador na rede e o arquivo ${WHITE}'hosts'${NONE}" 1
setIMessage "   Nome escolhido: ${WHITE}${TMP_CR}${NONE}"
alertUser
printf "${TMP_CR}\n" >> /etc/hostname
printf "127.0.0.1   localhost.localdomain localhost\n" >> /etc/hosts
printf "::1         localhost.localdomain localhost\n" >> /etc/hosts
printf "127.0.0.1   ${TMP_CR}.localdomain ${TMP_CR}\n" >> /etc/hosts



setIMessage " - Ativa a internet" 1
alertUser
systemctl enable NetworkManager



setIMessage " - Ativando o numlock por padrão"
alertUser
printf "#!/bin/bash\n\n" >> /usr/local/bin/numlock
printf "for tty in /dev/tty{1..6}; do\n" >> /usr/local/bin/numlock
printf "  /usr/bin/setleds -D +num < "\$tty";\n" >> /usr/local/bin/numlock
printf "done" >> /usr/local/bin/numlock

chmod u+x /usr/local/bin/numlock

printf "[Unit]\n" >> /etc/systemd/system/numlock.service
printf "Description=numlock\n" >> /etc/systemd/system/numlock.service
printf "\n" >> /etc/systemd/system/numlock.service
printf "[Service]\n" >> /etc/systemd/system/numlock.service
printf "ExecStart=/usr/local/bin/numlock\n" >> /etc/systemd/system/numlock.service
printf "StandardInput=tty\n" >> /etc/systemd/system/numlock.service
printf "RemainAfterExit=yes\n" >> /etc/systemd/system/numlock.service
printf "\n" >> /etc/systemd/system/numlock.service
printf "[Install]\n" >> /etc/systemd/system/numlock.service
printf "WantedBy=multi-user.target\n" >> /etc/systemd/system/numlock.service

systemctl enable numlock



setIMessage " - Liberar o grupo ${WHITE}'wheel'${NONE} para que ele seja um ${WHITE}'sudoer'${NONE}" 1
alertUser
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g' /etc/sudoers






TMP_MB=$(cat "tmpInstaller/varTMP_MB")
setIMessage "" 1
setIMessage "${CYAN}Etapa 03.1${NONE} - Configurando o ${WHITE}'grub'${NONE}"
setIMessage "             para o load do sistema ${WHITE}[${TMP_MB}]${NONE}."
setIMessage ""
alertUser

if [ "$TMP_MB" == "UEFI" ]; then
  grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
else
  grub-install --target=i386-pc --recheck /dev/sda
fi

cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
grub-mkconfig -o /boot/grub/grub.cfg





setIMessage "" 1
setIMessage "${CYAN}Etapa 03.2${NONE} - Configure uma senha para o usuário root."
setIMessage "${WHITE}[ Não deixe esta senha vazia ]${NONE}"
alertUser
passwd





setIMessage "" 1
setIMessage "${CYAN}03.3${NONE} - Instalação do ${WHITE}myShellEnv${NONE}."
setIMessage ""
setIMessage "-- Esta ação é opcional e pode ser realizada após o término da instalação principal."
setIMessage "   Deseja executar esta etapa agora?"
promptUser

# 
# prepara o instalador do myShellEnv
if [ "$MSE_GB_PROMPT_RESULT" == 1 ]; then
  TMP_TGT_URL="https://raw.githubusercontent.com/AeonDigital/myShellEnv/main/install.sh"
  $(curl -s -w "%{http_code}" -o "/root/myShellEnvInstall.sh" "${TMP_TGT_URL}" || true)

  chmod u+x "/root/myShellEnvInstall.sh"
  source /root/myShellEnvInstall.sh
  rm /root/myShellEnvInstall.sh
fi





setIMessage "" 1
setIMessage "${CYAN}Etapa 03.3${NONE} - Limpando o disco"
setIMessage ""
alertUser
pacman -Scc



setIMessage "" 1
setIMessage "${CYAN}03.4${NONE} - Seu computador está pronto para ser reiniciado."
setIMessage ""
setIMessage "-- Deseja efetuar o reboot agora?"
promptUser


if [ "$MSE_GB_PROMPT_RESULT" == 1 ]; then
  setIMessage "" 1
  setIMessage "${CYAN}Etapa 03${NONE} - Configuração do sistema concluída!."
  setIMessage "           Rode os comandos abaixo para ajustar o datetime da"
  setIMessage "           máquina para a região de São Paulo e executar o reboot."
  setIMessage ""
  setIMessage "${LBLUE}timedatectl set-timezone America/Sao_Paulo${NONE}"
  setIMessage ""
  setIMessage "${LGREEN}exit${NONE}"
  setIMessage "${LGREEN}umount -R /mnt${NONE}"
  setIMessage "${LGREEN}reboot${NONE}"
  setIMessage ""
  setIMessage "Lembre-se de remover o disco ou flashdrive antes de reiniciar."
  setIMessage ""
  alertUser

  rm install.sh
  rm -r tmpInstaller

else
  setIMessage "" 1
  setIMessage "-- Fim da execução!"
  setIMessage ""
  setIMessage ""
  alertUser
fi
