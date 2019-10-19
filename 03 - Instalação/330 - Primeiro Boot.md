# 330 - Preparando o primeiro boot
## 330.1 - Usando o grub
### 330.1.1 - Em BIOS

``` shell
  grub-install --target=i386-pc --recheck /dev/sda
```



### 330.1.2 - Em UEFI

``` shell
  grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch_grub --recheck
```



## 330.2 - Configurando o grub

``` shell
  mkdir /boot/grub/locale
  cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
  grub-mkconfig -o /boot/grub/grub.cfg
```



## 330.3 - Efetuando o primeiro reboot

Agora o novo sistema está instalado no seu computador e basta você dar um reboot, remover o 
**FlashDrive** da porta USB e então aguardar o novo S/O ser iniciado.

``` shell
  exit
  umount -R /mnt
  reboot
```
