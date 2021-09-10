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





clear
setIMessage "" 1
setIMessage "${CYAN}Arch Linux${NONE}"
setIMessage "${CYAN}Etapa 03${NONE} - Configuração do sistema."
setIMessage ""
alertUser


setIMessage " - Definindo o fuso-horário para ${WHITE}'America/Sao_Paulo'${NONE}" 1
alertUser
timedatectl set-timezone America/Sao_Paulo



setIMessage " - Habilitando o idioma ${WHITE}'pt-BR'${NONE}" 1
alertUser
sed -i 's/#pt_BR.UTF-8 UTF-8/pt_BR.UTF-8 UTF-8/g' /etc/locale.gen
echo LANG=pt_BR.UTF-8 >> /etc/locale.conf



setIMessage " - Configurando Layout do teclado ${WHITE}'abnt2'${NONE}" 1
alertUser
echo KEYMAP=br-abnt2 >> /etc/vconsole.conf



setIMessage " - Configurando fonte compatível com caracteres latinos" 1
alertUser
echo FONT=lat1-16 >> /etc/vconsole.conf



TMP_CR=$(cat "tmpInstaller/varTMP_CR")
setIMessage " - Configurar o nome do computador na rede e o arquivo ${WHITE}'hosts'${NONE}" 1
setIMessage"    Nome escolhido: ${WHITE}${TMP_CR}${NONE}"
alertUser
echo "$TMP_CR" >> /etc/hostname
echo "127.0.0.1   localhost.localdomain localhost" >> /etc/hosts
echo ""::1        localhost.localdomain localhost" >> /etc/hosts
echo "127.0.0.1   ${TMP_CR}.localdomain ${TMP_CR}" >> /etc/hosts



setIMessage " - Libera o grupo ${WHITE}'wheel'${NONE} para que ele seja um ${WHITE}'sudoer'${NONE}" 1
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g' /etc/sudoers
alertUser



setIMessage " - Ativa a internet" 1
systemctl enable NetworkManager
alertUser





TMP_MB=$(cat "tmpInstaller/varTMP_MB")
setIMessage "" 1
setIMessage "${CYAN}Etapa 03.1${NONE} - Configurando o ${WHITE}'grub'${NONE}"
setIMessage "             para o load do sistema [${WHITE}${TMP_MB}]${NONE}."
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
setIMessage "${DGREY}[ Não deixe esta senha vazia ]${NONE}"
alertUser
passwd





setIMessage "" 1
setIMessage "${CYAN}03.3${NONE} - Seu computador está pronto para ser reiniciado."
setIMessage ""
setIMessage "-- Deseja efetuar o reboot agora?"
promptUser

readNext ""
if [ "$MSE_GB_PROMPT_RESULT" == 1 ]; then
  setIMessage "" 1
  setIMessage "${CYAN}Etapa 03${NONE} - Configuração do sistema concluída!."
  setIMessage "           Rode os comandos abaixo para executar o reboot."
  setIMessage ""
  setIMessage "${LGREEN}exit${NONE}"
  setIMessage "${LGREEN}umount -R /mnt${NONE}"
  setIMessage "${LGREEN}reboot${NONE}"
  setIMessage ""
  setIMessage ""
  alertUser

  rm install.sh
  rm -r tmpInstaller
  rm varTMP_MB
  rm varTMP_CR
else
  setIMessage "" 1
  setIMessage "-- Fim da execução!"
  setIMessage ""
  setIMessage ""
  alertUser
fi
