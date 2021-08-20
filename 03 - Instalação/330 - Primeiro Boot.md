# 330 - Preparando o primeiro boot
## 330.1 - Usando o grub

``` shell
  # em UEFI
  grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB

  # em BIOS
  grub-install --target=i386-pc --recheck /dev/sda
```



&nbsp;

## 330.2 - Configurando o grub

``` shell
  cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo

  grub-mkconfig -o /boot/grub/grub.cfg
```



&nbsp;

## 330.3 - Redefinindo a senha do usuário root

Na última vez que executei este mesmo tutorial notei que ao fazer o reboot (a seguir) não foi 
possível efetuar o login pois não tinha feito uma senha para o usuário root e por algum motivo 
estranho o Arch (ao que tudo indica) gerou uma ele mesmo. Não consegui acessar nem deixando a 
senha vazia, nem usando como 'root' ou 'admin' ou outras variações comuns.  
Devido a esta situação que consegui contornar graças a um video-tutorial bem rápido e direto ao 
ponto resolvi adicionar esta ação aqui neste item para evitar que isto ocorra novamente.  

[O tutorial que me salvou foi este aqui](https://www.youtube.com/watch?v=AXSLkrd92BY)

``` shell
  # redefina a senha do seu usuário root antes de executar o primeiro reboot
  passwd
  New password: 
  Retype new password
```



&nbsp;

## 330.4 - Efetuando o primeiro reboot

Agora o novo sistema está instalado no seu computador e basta você dar um reboot, remover o 
**FlashDrive** da porta USB e então aguardar o novo S/O ser iniciado.

``` shell
  exit
  umount -R /mnt
  reboot
```
